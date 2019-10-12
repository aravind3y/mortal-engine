% Clear the existing workspace 

  
% Read the input image 
input = imread('stegoImage.png'); 
  
% Convert image to greyscale 
%input=rgb2gray(input); 
  
% Resize the image to required size 
input=imresize(input, [512 512]); 
  
height = size(input, 1); 
width = size(input, 2); 
  
  c='00000000';
  k=1;
  a=[];
% Traverse through the image 
for i = 1 : height 
    for j = 1 : width 
          
        % If there are more bits remaining to embed 
        
        if(k==9)
            b=bin2dec(c);
        a=[a b];
            k=1;
        end
        LSB = mod(double(input(i, j)), 2);
        if(LSB==0)
                c(k)=48;
        end
          if(LSB==1)
              c(k)=49;
          end
          k=k+1;
    end
end

char(a(1:13))
% Write both the input and output images to local storage 
% Mention the path to a folder here. 
