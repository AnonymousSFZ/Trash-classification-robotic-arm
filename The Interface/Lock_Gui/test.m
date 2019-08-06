function result=test(testdir, n, code, dkmax ,dkmin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function: test() ����
% input :   testdir : ���������ļ���
%           n       : testdir�в����ļ����е�N��
%           code    : ����˵������ѵ���õ�����
% output:   ���Խ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ע��:
%       testdir�������ļ����ĸ�ʽ����: 
%               1.wav, 2.wav, ..., n.wav

    % ��ȡÿ��˵���˵������ļ�read test sound file of each speaker
    global passcode
    file = sprintf('%s%d.wav', testdir, n);   
    cut(file);
    
    [s, fs] = audioread(file);      
        
    v = mfcc(s,fs);            % ����MFCC
   
    distmin = inf;              %����
    k1 = 0;
   
  for i = 1:length(code)      % code����󳤶ȣ�����ÿ��ѵ�����飬����ʧ��each trained codebook, compute distortion�����䣬ʧ�棩
        d = disteu(v, code{i}); %���� 
                dist = sum(min(d,[],2)) / size(d,1) %size(d,1): �еĳ��ȼ�����
          % min(A,[],dim),dimȡ1��2��ȡ1ʱ����min(A)��ȫ��ͬ��ȡ2ʱ���ú�������һ�������������i��Ԫ����A����ĵ�i���ϵ���Сֵ     
        if dist < distmin
            distmin = dist;
           k1 = i;
        end      
  end
  
  if distmin < 3.8
%       result = ['Correct! ', num2str(distmin)];
      passcode=1;      
      result = 'Correct! ';
  elseif distmin > 4
%       result = ['Wrong Code! ' , num2str(distmin)];
      result = 'Wrong Code! ';
      passcode=0;
  else result ='Again ' ;
      passcode=2;
  end
%   result = sprintf('��� %d ��˵����ƥ��', k1);
%     disp(msg);

