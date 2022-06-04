%Temel_islemler
%1. ve 2. adim 
clear all;
close all;
clc
Im_orj=imread('IMG_3405.jpg');
figure; 
subplot (2,1,1);
imshow(Im_orj);
xlabel('y düzlemi'), ylabel('x düzlemi'),title('Orijinal figure');
%3. adim
subplot (2,1,2);imhist(Im_orj);

%4. adim
Im_gray=rgb2gray(Im_orj);
Im_bw=im2bw(Im_orj);
Im_inv=imcomplement(Im_orj);

figure;

subplot(5,2,1);imshow(Im_orj);xlabel('y düzlemi'), ylabel('x düzlemi'),title('original figure')
subplot(5,2,2);imhist(Im_orj);xlabel('y düzlemi'), ylabel('x düzlemi'),title('histogram of original figure ')

subplot(5,2,3);imshow(Im_gray);xlabel('y düzlemi'), ylabel('x düzlemi'),title('gray figure')
subplot(5,2,4);imhist(Im_gray);xlabel('y düzlemi'), ylabel('x düzlemi'),title('histogram of gray figure ')

subplot(5,2,5);imshow(Im_bw);xlabel('y düzlemi'), ylabel('x düzlemi'),title('black-white figure')
subplot(5,2,6);imhist(Im_bw);xlabel('y düzlemi'), ylabel('x düzlemi'),title('histogram of black-white figure ')

subplot(5,2,7);imshow(Im_inv);xlabel('y düzlemi'), ylabel('x düzlemi'),title('inverse of black-white figure');
subplot(5,2,8);imhist(Im_inv);xlabel('y düzlemi'), ylabel('x düzlemi'),title('inverse of black-white figure histogram')

%5.adim

Im_grayhist=histeq(Im_gray);

subplot(5,2,9);imshow(Im_grayhist);xlabel('y düzlemi'), ylabel('x düzlemi'),title('After hist. equalization')
subplot(5,2,10);imhist(Im_grayhist);xlabel('y düzlemi'), ylabel('x düzlemi'),title('it''s histogram')

%6. adim
Im_gray=rgb2gray(Im_orj);
C=input('Enter Value of C ');
gamma=input('Enter Value of gamma ');

        G=256-Im_gray;
        H=uint8(C.*log(double(1+Im_gray)));
        I=uint8(C.*((double(Im_gray)).^gamma));
        
figure        
subplot(2,2,1);
imshow(Im_gray);
title('Original Image');
subplot(2,2,2);
imshow(G);
title('Negative Operator');

subplot(2,2,3);
imshow(H);
logtext=sprintf('Logarithmic Operator for C=%2.1f and gamma=%0.2f',C,gamma);
title(logtext);
 
subplot(2,2,4);
imshow(I);
powtext=sprintf('Power Law Operator for C=%2.1f and gamma=%0.2f',C,gamma);
title(powtext);

%%7.adim
Im_gray=rgb2gray(Im_orj);
%gaussian noise
G1 = imnoise(Im_gray,'gaussian',0.02);
G2 = imnoise(Im_gray,'gaussian',0.1);
G3 = imnoise(Im_gray,'gaussian',0.2);
G4 = imnoise(Im_gray,'gaussian',0.4);
G5 = imnoise(Im_gray,'gaussian',0.8);
G6 = imnoise(Im_gray,'gaussian',1);

figure
subplot(2,3,1);imshow(G1);title('value of gaussian value=0.02')
subplot(2,3,2);imshow(G2);title('value of gaussian value=0.1')
subplot(2,3,3);imshow(G3);title('value of gaussian value=0.2')
subplot(2,3,4);imshow(G4);title('value of gaussian value=0.4')
subplot(2,3,5);imshow(G5);title('value of gaussian value=0.8')
subplot(2,3,6);imshow(G6);title('value of gaussian value=1')

%salt & pepper noise
SP1 = imnoise(Im_gray,'salt & pepper',0.01);
SP2 = imnoise(Im_gray,'salt & pepper',0.03);
SP3 = imnoise(Im_gray,'salt & pepper',0.05);
SP4 = imnoise(Im_gray,'salt & pepper',0.4);
SP5 = imnoise(Im_gray,'salt & pepper',0.8);
SP6 = imnoise(Im_gray,'salt & pepper',1);
figure
subplot(2,3,1);imshow(SP1);title('value of salt & pepper value=0.01')
subplot(2,3,2);imshow(SP2);title('value of salt & pepper value=0.03')
subplot(2,3,3);imshow(SP3);title('value of salt & pepper value=0.05')
subplot(2,3,4);imshow(SP4);title('value of salt & pepper value=0.4')
subplot(2,3,5);imshow(SP5);title('value of salt & pepper value=0.8')
subplot(2,3,6);imshow(SP6);title('value of salt & pepper value=1')



%speckle noise
S1 = imnoise(Im_gray,'speckle',0.01);
S2 = imnoise(Im_gray,'speckle',0.04);
S3 = imnoise(Im_gray,'speckle',0.06);
S4 = imnoise(Im_gray,'speckle',0.8);
S5 = imnoise(Im_gray,'speckle',1);
S6 = imnoise(Im_gray,'speckle',1.2);
figure
subplot(2,3,1);imshow(S1);title('value of  speckle=0.01')
subplot(2,3,2);imshow(S2);title('value of speckle value=0.04')
subplot(2,3,3);imshow(S3);title('value of speckle value=0.06')
subplot(2,3,4);imshow(S4);title('value of speckle value=0.08')
subplot(2,3,5);imshow(S5);title('value of speckle value=1')
subplot(2,3,6);imshow(S6);title('value of speckle value=1.2')

% % % % Ödev_2 baIlangIcI


% Ilk ödevde C.7 adImInda elde edilen farklI ortalama deIere ve varyansa sahip Gaussian 
% gürültüsü eklenmis görüntü üzerinde,
% a. Ortalama (mean) filtresi uygulayInIz. Filtrelenmiş ve filtrelenmemiş figürleri aynI figür 
% penceresinde gösteriniz ve sonucu yorumlayınız. Filtre boyutunu değiştirerek aynI 
% işlemleri tekrarlayınız

%AçIklama: c7 adImInda G1 olarak gaussian gürültü eklenmiI formu
%verilmiItir. gray forma alInmII her gürültü için unique olacak Iekilde
%tanImlamalar yapIlmıştır.

%Mean filter uygulanmasi
%gaussian eklenmiI fotoIraf G1'dir

[m,n] = size(G1);

output = zeros(m,n);

for i=1:m
    for j=1:n
        %  neighborhood matrix sInIrlarI belirliyoruz.
        rmin = max(1,i-1);
        rmax = min(m,i+1);
        cmin = max(1,j-1);
        cmax = min (n,j+1);
        
        %neighborhood matrix temp olarak atandı.
        temp = G1(rmin:rmax,cmin:cmax);
        
        % çıktının i. pixeli neighborhood matrix ortalaması olacaktIr.
        
        output(i,j) = mean(temp(:));
    end
end

% çikisi uint8 olarak convert edelim

output = uint8(output);

figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(G1),title('original Image');
subplot(122),imshow(output),title('output of mean filter');
        

%Gaussian gürültülü görüntüye Ortanca filtre uygulayalIm.


[m,n] = size(G1);

output = zeros(m,n);
output = uint8(output);

for i = 1:m
   for j = 1:n %neighborhood matrix sınırlarını belirliyoruz.
        
       
       xmin=max(1,i-1);
       xmax = min(m,i+1);
       ymin = max(1,j-1);
       ymax = min(n,j+1);
       
       %neighborhood matrix temp olarak atandı.
       temp = G1(xmin:xmax,ymin:ymax);
       %medyan filtre tanImlandI.
       output(i,j) = median(temp(:));
   end
end

figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(G1),title('original Image');
subplot(122),imshow(output),title('output of median filter');

%Gaussian gürültülü görüntüye Gaussian filtre uygulayalIm.

sigma = 1;
kernel = zeros(5,5);
W = 0;


for i = 1:5
    for j = 1:5
        sq_dist = (i-3)^2 + (j-3)^2;
        kernel(i,j) = exp(-1*(sq_dist)/(2*sigma*sigma));
        W = W + kernel(i,j);
    end
end
kernel = kernel/W;

[m,n] = size(G1);
output = zeros(m,n);
G1 = padarray(G1,[2 2]);

for i = 1:m
   for j = 1:n %neighborhood matrix sınırlarını belirliyoruz.
        
         
     %neighborhood matrix temp olarak atandı.
       temp = G1(i:i+4 , j:j+4);
       temp = double(temp);
       conv = temp.*kernel;
       %medyan filtre tanImlandI.
       output(i,j) = median(temp(:));
   end
end

output = uint8(output);
figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(G1),title('original Image');
subplot(122),imshow(output),title('output of gaussian filter');

---------------------------------------------------
%2.AdIm.

%Salt peper gürültü üzerine mean filter eklenmesi


[m,n] = size(SP1);

output = zeros(m,n);

for i=1:m
    for j=1:n
        %  neighborhood matrix sInIrlarI belirliyoruz.
        rmin = max(1,i-1);
        rmax = min(m,i+1);
        cmin = max(1,j-1);
        cmax = min (n,j+1);
        
        %neighborhood matrix temp olarak atandı.
        temp = SP1(rmin:rmax,cmin:cmax);
        
        % çIktInIn i. pixeli neighborhood matrix ortalaması olacaktIr.
        
        output(i,j) = mean(temp(:));
    end
end

% Çıkışı uint8 olarak convert edelim

output = uint8(output);

figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(SP1),title('original Image');
subplot(122),imshow(output),title('output of mean filter');


%b seçeneği:


[m,n] = size(SP1);

output = zeros(m,n);
output = uint8(output);

for i = 1:m
   for j = 1:n %neighborhood matrix sınırlarını belirliyoruz.
        
       
       xmin=max(1,i-1);
       xmax = min(m,i+1);
       ymin = max(1,j-1);
       ymax = min(n,j+1);
       
       %neighborhood matrix temp olarak atandı.
       temp = SP1(xmin:xmax,ymin:ymax);
       %medyan filtre tanImlandI.
       output(i,j) = median(temp(:));
   end
end

figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(SP1),title('original Image');
subplot(122),imshow(output),title('output of median filter');

% c seçeneği

sigma = 1;
kernel = zeros(5,5);
W = 0;


for i = 1:5
    for j = 1:5
        sq_dist = (i-3)^2 + (j-3)^2;
        kernel(i,j) = exp(-1*(sq_dist)/(2*sigma*sigma));
        W = W + kernel(i,j);
    end
end
kernel = kernel/W;

[m,n] = size(SP1);
output = zeros(m,n);
SP1 = padarray(SP1,[2 2]);

for i = 1:m
   for j = 1:n %neighborhood matrix sınırlarını belirliyoruz.
        
         
     %neighborhood matrix temp olarak atandı.
       temp = SP1(i:i+4 , j:j+4);
       temp = double(temp);
       conv = temp.*kernel;
       %medyan filtre tanImlandI.
       output(i,j) = median(temp(:));
   end
end

output = uint8(output);
figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(SP1),title('original Image');
subplot(122),imshow(output),title('output of gaussian filter');

%3.BÖLÜM 
%A SEÇENEĞİ

[m,n] = size(S3);

output = zeros(m,n);

for i=1:m
    for j=1:n
        %  neighborhood matrix sInIrlarI belirliyoruz.
        rmin = max(1,i-1);
        rmax = min(m,i+1);
        cmin = max(1,j-1);
        cmax = min (n,j+1);
        
        %neighborhood matrix temp olarak atandı.
        temp = S3(rmin:rmax,cmin:cmax);
        
        % çIktInIn i. pixeli neighborhood matrix ortalaması olacaktIr.
        
        output(i,j) = mean(temp(:));
    end
end

% çikisi uint8 olarak convert edelim

output = uint8(output);

figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(S3),title('original Image');
subplot(122),imshow(output),title('output of mean filter');

% B seçeneği

[m,n] = size(S3);

output = zeros(m,n);
output = uint8(output);

for i = 1:m
   for j = 1:n %neighborhood matrix sınırlarını belirliyoruz.
        
       
       xmin=max(1,i-1);
       xmax = min(m,i+1);
       ymin = max(1,j-1);
       ymax = min(n,j+1);
       
       %neighborhood matrix temp olarak atandı.
       temp = S3(xmin:xmax,ymin:ymax);
       %medyan filtre tanImlandI.
       output(i,j) = median(temp(:));
   end
end

figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(S3),title('çarpImsal gürültülü Image');
subplot(122),imshow(output),title('output of median filter');

% C seçeneği 
%Normal (Gaussian) filtresi uygulayInIz. Filtrelenmiş ve filtrelenmemiş figürleri aynI figür 
% penceresinde gösteriniz ve sonucu yorumlayınız. Filtre boyutunu değiştirerek aynI 
% işlemleri tekrarlayınız. 

sigma = 1;
kernel = zeros(5,5);
W = 0;


for i = 1:5
    for j = 1:5
        sq_dist = (i-3)^2 + (j-3)^2;
        kernel(i,j) = exp(-1*(sq_dist)/(2*sigma*sigma));
        W = W + kernel(i,j);
    end
end
kernel = kernel/W;

[m,n] = size(S3);
output = zeros(m,n);
S3 = padarray(S3,[2 2]);

for i = 1:m
   for j = 1:n %neighborhood matrix sınırlarını belirliyoruz.
        
         
     %neighborhood matrix temp olarak atandı.
       temp = S3(i:i+4 , j:j+4);
       temp = double(temp);
       conv = temp.*kernel;
       %medyan filtre tanImlandI.
       output(i,j) = median(temp(:));
   end
end

output = uint8(output);
figure(1);
set(gcf,'position', get(0,'Screensize'));
subplot(121),imshow(S3),title('original Image');
subplot(122),imshow(output),title('output of gaussian filter');





