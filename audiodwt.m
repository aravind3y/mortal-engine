[name, path] = uigetfile('*.wav', 'Select Sound File');
fid = fopen([path name], 'r');
header = fread(fid, 40, 'uint8=>char');
fdLen = fread(fid, 1, 'uint32');
IdKeyinD = fread(fid, 64, 'uint8');
IdKeyinD_bin = bitget(IdKeyinD(1:end), 1);
DLen = fread(fid, 32, 'uint32');
%calculating the length of stego samples

bin_DLen = bitget(DLen, 1)';
numOel = bi2de(bin_DLen);
% take in the stego data
audio_ = fread(fid, numOel, 'uint16');
fclose(fid);
%audiowrite('testdwt2.wav',audio_,a);
b = size(audio_,1);
if(mod(b,2)==1)
b=b-1;
end
mid=b/2;
audiodata = zeros(b,1);
audiodata1 = audio_;
for i = 1:mid
    audiodata(i)   = (audiodata1(2*i-1) + audiodata1(2*i)) ;
    audiodata(i+mid) = (audiodata1(2*i-1) - audiodata1(2*i)) ;
end

message='folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folkshappy diwali folks';  %% make it file compatible
DLen(1)=length(message);
len = length(message) * 4; 
ascii_value = uint8(message); 

% Convert the decimal values to binary
checkme=dec2base(ascii_value, 2);

bin_message = transpose(checkme);

% Get all the binary digits in separate row 
bin_message = bin_message(:);
bin_message = str2num(bin_message);%bin_message = transpose(dec2base(ascii_value, 2));
k=1;
check1=audiodata;
for i = mid+1:b
    audiodata(i) = audiodata(i) - mod(audiodata(i),2) + bin_message(k);
    if(k==length(bin_message))
    break;
    end
    k=k+1;
    
   
end
check2=audiodata;
audiodata2 = audiodata;
for i = 1:mid
    audiodata(2*i-1)   = (audiodata2(i) + audiodata2(i+mid))/2.0 ;
    audiodata(2*i) = (audiodata2(i) - audiodata2(i+mid))/2.0;
end



fid3 = fopen('stego2.wav', 'w');
fwrite(fid3, header, 'uint8');
fwrite(fid3, fdLen, 'uint32');
%writing secret key and length of data
fwrite(fid3, IdKeyinD, 'uint8');
fwrite(fid3, DLen, 'uint32');
%writing the stego data
fwrite(fid3, audiodata, 'uint16');
fclose(fid3);

fid4 = fopen('noise.wav', 'w');
fwrite(fid4, header, 'uint8');
fwrite(fid4, fdLen, 'uint32');
%writing secret key and length of data
fwrite(fid4, IdKeyinD, 'uint8');
fwrite(fid4, DLen, 'uint32');
%writing the stego data
fwrite(fid4, check2-check1, 'uint16');
fclose(fid4);
