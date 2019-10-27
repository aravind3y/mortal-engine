myimage1=imread('original_image.jpg');
myimage1=rgb2gray(myimage1);
myimage1 = im2double(myimage1).*255;
height=size(myimage1,1);
width=size(myimage1,2);
%myimage=myimage1;
imagedata = zeros(height,width);
%width=width-1;
height=height-1;
%row
for i=1:height
for j=1:(width/2)
    imagedata(i,j)=(myimage1(i,2*j-1)+myimage1(i,2*j))/2;
    imagedata(i,j+width/2)=(myimage1(i,2*j-1)-myimage1(i,2*j))/2;
end
end
%column
imagedata2=imagedata;
for j=1:width
for i=1:(height/2)
    imagedata(i,j)=(imagedata2(2*i-1,j)+imagedata2(2*i,j))/2;
    imagedata(i+height/2,j)=(imagedata2(2*i-1,j)-imagedata2(2*i,j))/2;
end
end
myimage = imagedata;
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
    imagedata(i,j)=imagedata(i,j)+finalarray(k)-mod(imagedata(i,j),4);
   
   % LH and HL code
     if(bin_message(2*k-1) == 0)
         if(bin_message(2*k) == 0)
               imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+0-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+0-mod(imagedata(i-(width/2),j),2); %LH
         end
         if(bin_message(2*k) == 1)
               imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+0-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+2-mod(imagedata(i-(width/2),j),4); %LH
         end
         if(bin_message(2*k) == 2)
             imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+0-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+1-mod(imagedata(i-(width/2),j),2); %LH
         end
         if(bin_message(2*k) == 3)
              % imagedata(i,j-(height/2)) =
             imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+1-mod(imagedata(i-(width/2),j),2); %LH
         end
     end
     if(bin_message(2*k-1) == 1)
         if(bin_message(2*k) == 0)
              imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+0-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+0-mod(imagedata(i-(width/2),j),4); %LH
         end
         if(bin_message(2*k) == 1)
               imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+1-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+0-mod(imagedata(i-(width/2),j),2); %LH
        
         end
         if(bin_message(2*k) == 2)
             imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+1-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+2-mod(imagedata(i-(width/2),j),4); %LH
         end
         if(bin_message(2*k) == 3)
             imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+1-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+1-mod(imagedata(i-(width/2),j),2); %LH
       
         end
     end
     if(bin_message(2*k-1) == 2)
         if(bin_message(2*k) == 0)
             imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+0-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+0-mod(imagedata(i-(width/2),j),2); %LH
       
         end
         if(bin_message(2*k) == 1)
               imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+1-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+0-mod(imagedata(i-(width/2),j),4); %LH
         end
         if(bin_message(2*k) == 2)
              imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+0-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+1-mod(imagedata(i-(width/2),j),2); %LH
         end
         if(bin_message(2*k) == 3)
              imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+0-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+3-mod(imagedata(i-(width/2),j),4); %LH
         end
     end
     if(bin_message(2*k-1) == 3)
         if(bin_message(2*k) == 0)
              % imagedata(i,j-(height/2)) =
             imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+0-mod(imagedata(i-(width/2),j),2); %LH
       
         end
         if(bin_message(2*k) == 1)
               imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+1-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+0-mod(imagedata(i-(width/2),j),2); %LH
         end
         if(bin_message(2*k) == 2)
               imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+0-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+1-mod(imagedata(i-(width/2),j),4); %LH
         end
         if(bin_message(2*k) == 3)
               imagedata(i,j-(height/2)) = imagedata(i,j-(height/2))+1-mod(imagedata(i,j-(height/2)),2); %HL
               imagedata(i-(width/2),j) = imagedata(i-(width/2),j)+1-mod(imagedata(i-(width/2),j),2); %LH
         end
     end
   
     k=k+1;
    if(k==len/2)
    break;

    end
end
if(k==len/2)
break;
end
end
myimage = uint8(imagedata);
myimage1 = uint8(myimage1);
imwrite(myimage1, 'originalImage.png'); 
imwrite(myimage, 'stegoImage2.png');

