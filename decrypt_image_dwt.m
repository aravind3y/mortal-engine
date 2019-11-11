myimage1d =imread("stegoImage2.png");
myimage1d = im2double(myimage1d).*255;

dat=imfinfo("stegoImage2.png");
comment=dat.Comment;
height=size(myimage1,1);
width=size(myimage1,2);
comment = comment(:);
imagedatadec = zeros(height,width);

k=1;
for i=1:height
    for j = 1:width
    myimage1d(i,j) =  myimage1d(i,j) + (str2num(comment(k))*0.25) ;
    k = k+1;
    end
end

%row
for i=1:height
for j=1:(width/2)
    imagedatadec(i,j)=myimage1d(i,2*j-1)+myimage1d(i,2*j);
    imagedatadec(i,j+width/2)=myimage1d(i,2*j-1)-myimage1d(i,2*j);
end
end
%column
imagedata2=imagedatadec;
for j=1:width
for i=1:(height/2)
    imagedatadec(i,j)=imagedata2(2*i-1,j)+imagedata2(2*i,j);
    imagedatadec(i+height/2,j)=imagedata2(2*i-1,j)-imagedata2(2*i,j);
end
end
imagedatatest2 = imagedatadec;
l = dat.Source;
finalarray = zeros(2*str2num(l),1);
bin_message = zeros(4*str2num(l),1) + 99;
k=1;
%HH
for i=(height/2)+1:height
for j=(width/2)+1:width
    finalarray(k)=mod(imagedatadec(i,j),4);
   
   % LH and HL code
    if(finalarray(k) == 0)
        if(mod(imagedatadec(i,j-(width/2)),2) == 0) %LH
            if(mod(imagedatadec(i-(height/2),j),2) == 0)%HL
                bin_message(2*k-1)=0;
                bin_message(2*k) = 0;
            else 
                 bin_message(2*k-1)=1;
                bin_message(2*k) = 1;
            end
        else                                      %LH
            if(mod(imagedatadec(i-(height/2),j),2) == 0)%HL
                 bin_message(2*k-1)=2;
                bin_message(2*k) = 2;
            else
                bin_message(2*k-1)=3;
                bin_message(2*k) = 3; 
            end    
        end    
    end
    if(finalarray(k) == 1)
        if(mod(imagedatadec(i,j-(width/2)),4) == 0) %LH
            if(mod(imagedatadec(i-(height/2),j),2) == 0)%HL
                bin_message(2*k-1)=1;
                bin_message(2*k) = 0;
            else 
                 bin_message(2*k-1)=2;
                bin_message(2*k) = 1;
            end
        elseif(mod(imagedatadec(i,j-(width/2)),4) == 1)                                      %LH
            if(mod(imagedatadec(i-(height/2),j),2) == 0)%HL
                 bin_message(2*k-1)=3;
                bin_message(2*k) = 2; 
            end 
        elseif(mod(imagedatadec(i,j-(width/2)),4) == 2)
            if(mod(imagedatadec(i-(height/2),j),2) == 0)%HL
                bin_message(2*k-1)=0;
                bin_message(2*k) = 1;
            else 
                 bin_message(2*k-1)=1;
                bin_message(2*k) = 2;
            end
        elseif(mod(imagedatadec(i,j-(width/2)),4) == 3)
            if(mod(imagedatadec(i-(height/2),j),2) == 0)%HL
                 bin_message(2*k-1)=2;
                bin_message(2*k) = 3; 
            end
        end    
    end
    if(finalarray(k) == 2)
        if(mod(imagedatadec(i,j-(width/2)),2) == 0) %LH
            if(mod(imagedatadec(i-(height/2),j),2) == 0)%HL
                bin_message(2*k-1)=2;
                bin_message(2*k) = 0;
            else 
                 bin_message(2*k-1)=3;
                bin_message(2*k) = 1;
            end
        else                                      %LH
            if(mod(imagedatadec(i-(height/2),j),2) == 0)%HL
                 bin_message(2*k-1)=0;
                bin_message(2*k) = 2;
            else
                bin_message(2*k-1)=1;
                bin_message(2*k) = 3; 
            end    
        end    
    end
    if(finalarray(k) == 3)
        if(mod(imagedatadec(i,j-(width/2)),2) == 0) %LH
            bin_message(2*k-1)=3;
                bin_message(2*k) = 0;
        else
            bin_message(2*k-1)=0;
                bin_message(2*k) = 3;
        end
    end
    
    if(k==length(finalarray))
       break;
    end
    k=k+1;        
end
if(k==length(finalarray))
       break;
end
end
compar2=finalarray;
getmessageascii = zeros(length(bin_message)/4,1);
for  i = 1:length(bin_message)/4
    getmessageascii(i) = 64*bin_message(4*i-3) + 16*bin_message(4*i-2) + 4*bin_message(4*i-1) + bin_message(4*i);
end

message = char(getmessageascii);