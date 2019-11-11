myimage1=imread("ladki.jpeg");
%myimage1=imresize(myimage1,[100 100]);
myimage1=rgb2gray(myimage1);
myimage1 = im2double(myimage1).*255;
height=size(myimage1,1);
width=size(myimage1,2);

imagedata = zeros(height,width);
%width=width-1;
%height=height-1;
%row
for i=1:height
for j=1:(width/2)
    imagedata(i,j)=myimage1(i,2*j-1)+myimage1(i,2*j);
    imagedata(i,j+width/2)=myimage1(i,2*j-1)-myimage1(i,2*j);
end
end
%column
imagedata2=imagedata;
for j=1:width
for i=1:(height/2)
    imagedata(i,j)=imagedata2(2*i-1,j)+imagedata2(2*i,j);
    imagedata(i+height/2,j)=imagedata2(2*i-1,j)-imagedata2(2*i,j);
end
end

messageencrypt='Resize the image again, this time specifying the desired size of the output image, rather than a magnification value. Pass imresize a vector that contains the number of rows and columns in the output image. If the specified size does not produce the same aspect ratio as the input image, the output image will be distorted. If you specify one of the elements in the vector as NaN, imresize calculates the value for that dimension to preserve the aspect ratio of the image. To perform the resizing required for multi-resolution';
% Length of the message where each character is 8 bits 
len = length(messageencrypt) * 4; 

% Get all the ASCII values of the characters of the message 
ascii_value = uint8(messageencrypt); 
kk=dec2base(ascii_value, 4);
% Convert the decimal values to binary
checkme=dec2base(ascii_value, 4);

bin_message = transpose(checkme);

% Get all the binary digits in separate row 
bin_message = bin_message(:);
bin_message = str2num(bin_message);
checkbin1=bin_message;
finalarray=zeros(1,len/2);
for i=1:len/2
finalarray(i)=abs(bin_message(2*i-1)-bin_message(2*i));
end
k=1;
c2=imagedata;
%HH
for i=(height/2)+1:height
for j=(width/2)+1:width
    imagedata(i,j)=imagedata(i,j)+finalarray(k)-mod(imagedata(i,j),4);
   
   % LH and HL code
     if(bin_message(2*k-1) == 0)
         if(bin_message(2*k) == 0)
               imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+0-mod(imagedata(i,j-(width/2)),2); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
         end
         if(bin_message(2*k) == 1)
               imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+2-mod(imagedata(i,j-(width/2)),4); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
        end
         if(bin_message(2*k) == 2)
         imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+1-mod(imagedata(i,j-(width/2)),2); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
        end
         if(bin_message(2*k) == 3)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+1-mod(imagedata(i,j-(width/2)),2); %LH
               %imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
         end
     end
     if(bin_message(2*k-1) == 1)
         if(bin_message(2*k) == 0)
              imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+00-mod(imagedata(i,j-(width/2)),4); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
        end
         if(bin_message(2*k) == 1)
         imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+0-mod(imagedata(i,j-(width/2)),2); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+1-mod(imagedata(i-(height/2),j),2); %HL
         end
         if(bin_message(2*k) == 2)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+2-mod(imagedata(i,j-(width/2)),4); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+1-mod(imagedata(i-(height/2),j),2); %HL
         end
         if(bin_message(2*k) == 3)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+1-mod(imagedata(i,j-(width/2)),2); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+1-mod(imagedata(i-(height/2),j),2); %HL
        
         end
     end
     if(bin_message(2*k-1) == 2)
         if(bin_message(2*k) == 0)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+0-mod(imagedata(i,j-(width/2)),2); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
        
         end
         if(bin_message(2*k) == 1)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+0-mod(imagedata(i,j-(width/2)),4); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+1-mod(imagedata(i-(height/2),j),2); %HL
         end
         if(bin_message(2*k) == 2)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+1-mod(imagedata(i,j-(width/2)),2); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
         end
         if(bin_message(2*k) == 3)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+3-mod(imagedata(i,j-(width/2)),4); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
         end
     end
     if(bin_message(2*k-1) == 3)
         if(bin_message(2*k) == 0)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+0-mod(imagedata(i,j-(width/2)),2); %LH
               %imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
        
         end
         if(bin_message(2*k) == 1)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+0-mod(imagedata(i,j-(width/2)),2); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+1-mod(imagedata(i-(height/2),j),2); %HL
         end
         if(bin_message(2*k) == 2)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+1-mod(imagedata(i,j-(width/2)),4); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+0-mod(imagedata(i-(height/2),j),2); %HL
         end
         if(bin_message(2*k) == 3)
        imagedata(i,j-(width/2)) = imagedata(i,j-(width/2))+1-mod(imagedata(i,j-(width/2)),2); %LH
               imagedata(i-(height/2),j) = imagedata(i-(height/2),j)+1-mod(imagedata(i-(height/2),j),2); %HL
         end
     end
   if(k==len/2)
    break;
   end
     k=k+1;
    

end
if(k==len/2)
break;
end
end
imagedatatest = imagedata;



finalimagedata=zeros(height,width);
%column
for j=1:width
for i=1:(height/2)
    finalimagedata(2*i-1,j)=(imagedata(i,j)+imagedata(i+height/2,j))/2.0;
    finalimagedata(2*i,j)=(imagedata(i,j)-imagedata(i+height/2,j))/2.0;
end
end
finalimage2=finalimagedata;
%row
for i=1:height
for j=1:(width/2)
    finalimagedata(i,2*j-1)=(finalimage2(i,j)+finalimage2(i,j+width/2))/2.0;
    finalimagedata(i,2*j)=(finalimage2(i,j)-finalimage2(i,j+width/2))/2.0;
end
end
k="";
check2=finalimagedata;
for i=1:height
    for j=1:width
    k=k+ mod(finalimagedata(i,j)*100,100)/25;
    finalimagedata(i,j)=finalimagedata(i,j)-mod(finalimagedata(i,j)*100,100)/100;
    
    
    end
    
end
b = strlength(k);
myimage = uint8(finalimagedata);
myimage1 = uint8(myimage1);

imwrite(myimage1, 'originalImage.png'); 
imwrite(abs(myimage-myimage1),'noiseimage.png');
imwrite(myimage, 'stegoImage2.png','Comment',k,'Source',num2str(length(messageencrypt)));

