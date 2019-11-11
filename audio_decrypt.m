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
mid = (b)/2;
audiodata = zeros(b,1);
audiodata1 = audio_;
for i = 1:mid
    audiodata(i)   = (audiodata1(2*i-1) + audiodata1(2*i)) ;
    audiodata(i+mid) = (audiodata1(2*i-1) - audiodata1(2*i)) ;
end

%bin_message = transpose(dec2base(ascii_value, 2));
k=1;

len = DLen(1) *7;
data = zeros(len,1);
sop=size(data,1);
for i = mid+1:b
    data(k) = mod(audiodata(i),2);
    if(k==len)
    break;
    end
    
    k=k+1;
end

getascii = zeros(DLen(1),1);
for i = 1:DLen(1)
    getascii(i) = 64*data(7*i-6) +32*data(7*i-5) +16*data(7*i-4) +8*data(7*i-3) +4*data(7*i-2) +2*data(7*i-1) +1*data(7*i); ;
end

message = char(getascii);