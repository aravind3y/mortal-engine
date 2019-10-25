myimage1=imread("download.jpeg");
myimage1=rgb2gray(myimage1);
height=size(myimage1,1);
width=size(myimage1,2);
myimage=myimage1;
width=width-1;
height=height-1;
%row
for i=1:height
for j=1:(width/2)
    myimage(i,j)=(myimage1(i,2*j-1)+myimage1(i,2*j))/2;
    myimage(i,j+width/2)=(myimage1(i,2*j-1)-myimage1(i,2*j))/2;
end
end
%column
myimage2=myimage;
for j=1:width
for i=1:(height/2)
    myimage(i,j)=(myimage2(2*i-1,j)+myimage2(2*i,j))/2;
    myimage(i+height/2,j)=(myimage2(2*i-1,j)-myimage2(2*i,j))/2;
end
end


imwrite(myimage1, 'originalImage.png'); 
imwrite(myimage, 'stegoImage.png');
message='happy diwali folks';
% Length of the message where each character is 8 bits 
len = length(message) * 4; 

% Get all the ASCII values of the characters of the message 
ascii_value = uint8(message); 

% Convert the decimal values to binary 
bin_message = transpose(dec2base(ascii_value, 4));

% Get all the binary digits in separate row 
bin_message = bin_message(:); 
finalarray=zeros(1,len/2);
for i=1:len/2
finalarray(i)=abs(bin_message(2*i-1)-bin_message(2*i));
end
k=1;
%HH
for i=(width/2)+1:width
for j=(height/2)+1:height
    myimage(i,j)=myimage(i,j)+finalarray(k)-mod(myimage(i,j),4);
    k=k+1;
    if(k==len/2)
    break;
    
    end
end
if(k==len/2)
break;
end
end
%HL
for i=1:width/2
for j=(height/2)+1:height
    myimage(i,j)=myimage(i,j)+finalarray(k)-mod(myimage(i,j),4);
    k=k+1;
    if(k==len/2)
    break;
    
    end
end
if(k==len/2)
break;
end
end
%LH