X0=0;
Y0=0;
H0=785;
W0=2000;
figure('position',[X0,Y0,W0,H0]);
dx=50;
dy=50;
w=1380;
h=300;
w2=100;
h2=50;
x0=60;
y0=100;

hAxes1=axes('Units','pixels','Position',[x0,y0,w+60,h]);
hAxes2=axes('Units','pixels','Position',[x0,y0+h+dy,w,h]);

set(hAxes2,"XLim",[0 10]);
Fs=1500;
T=1/Fs;
tmax=10;
t=0:T:tmax-T;
N=15000;
n=N/10;
recObj = audiorecorder(2000,16,1,1);
y2=zeros(15000,1);

Ny2=length(y2);
ncs=floor(Ny2/24);
nov=floor(ncs/2);
nfft = 2^nextpow2(ncs);

for i=1:9
 recordblocking(recObj, 1);
 y1=getaudiodata(recObj);
 y2(N-(i+1)*n:N-i*n-1,1)=y2(N-i*n:N-(i-1)*n-1,1);
 y2(N-i*n:N-(i-1)*n-1,1)=y1(500:1999,1); % первые 500 отчётов неинформативны
 axes(hAxes2)
 plot(t,y2)
 title('audiosignal')
%play(recObj);
 axes(hAxes1)
 spectrogram(y2(:,1),hamming(ncs),nov,nfft,Fs,'yaxis');
 title('spectrogram')
 if i==8
     for j=1:tmax/T
     recordblocking(recObj, 1);
     y1=getaudiodata(recObj);
     y2(1:N-n,1)=y2(n:N-1,1);
     y2(N-n:N-1,1)=y1(500:1999,1);   
     axes(hAxes2)
     plot(t,y2)
     title('audiosignal')
     j=j+1;
%    play(recObj);
     axes(hAxes1)
     spectrogram(y2(:,1),hamming(ncs),nov,nfft,Fs,'yaxis');
     title('spectrogram')
     end
 end
end

