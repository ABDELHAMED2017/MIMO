clear; close all; clc;
K=20;
M=20;
N=100;
MI=zeros(8,19);
m=1;
t=10;  %��ʽ10���ֵ��ѭ������
for method=4:5
    s=1;
for SNR=-20:5/3:10
    temp=0;
    for h=1:t
        I=0;
        jj=0;
        pxk=zeros(1,4);
        [p,px,A,y ]=GenP(SNR,K,M,N,method);
        for k=1:4
            for kk=1:4
                pxk(k)=pxk(k)+p(4*(kk-1)+k)*px(kk);
            end
        end
        for j=1:16
            if(p(j)>0&&pxk(j-4*jj)>0)
                I=I+p(j)*px(fix(j/4.1)+1)*log(p(j)/pxk(j-4*jj))/log(2);  %pxk(j-4*jj)����Ϊ0
            end
            if(mod(j,4)==0)
                jj=jj+1;
            end
        end
        temp=temp+I;
    end
    MI(m,s)=temp/t;  % m��ʾͼ2��ĳ����
    s=s+1;  % s��ʾ����ĵڼ���ֵ
end
    m=m+1;
end

for method=1:3
    s=1;
for SNR=-20:5/3:10
    temp=0;
    for h=1:t
        I=0;
        jj=0;
        pxk=zeros(1,4);
        [p,px,A,y ]=GenP(SNR,K,M,N,method);
        for k=1:4
            for kk=1:4
                pxk(k)=pxk(k)+p(4*(kk-1)+k)*px(kk);
            end
        end
        for j=1:16
            if(p(j)>0)
                I=I+p(j)*px(fix(j/4.1)+1)*log(p(j)/pxk(j-4*jj))/log(2);
            end
            if(mod(j,4)==0)
                jj=jj+1;
            end
        end
        temp=temp+I;
    end
    MI(m,s)=temp/t;
    s=s+1;
end
    m=m+1;
end
%����N=50M
for method=1:3
    s=1;
for SNR=-20:5/3:10
    temp=0;
    for h=1:t
        I=0;
        jj=0;
        pxk=zeros(1,4);
        [p,px,A,y ]=GenP(SNR,K,M,N*10,method);
        for k=1:4
            for kk=1:4
                pxk(k)=pxk(k)+p(4*(kk-1)+k)*px(kk);
            end
        end
        for j=1:16
            if(p(j)>0)
                I=I+p(j)*px(fix(j/4.1)+1)*log(p(j)/pxk(j-4*jj))/log(2);
            end
            if(mod(j,4)==0)
                jj=jj+1;
            end
        end
        temp=temp+I;
    end
    MI(m,s)=temp/t;
    s=s+1;
end
    m=m+1;
end

MI = MI*2; % 08.06��
save MI MI;
%��ͼ����
hf = figure;
set( hf, 'color', 'white');
SNR=-20:5/3:10;
plot( SNR, MI(1,:), '-bo','LineWidth',1.5);
hold on;
plot( SNR, MI(2,:), '-rs','LineWidth',1.5);
hold on;
plot( SNR, MI(3,:), '-.k*','LineWidth',1.5);
hold on;
plot( SNR, MI(4,:), '-.bo','LineWidth',1.5);
hold on;
plot( SNR, MI(5,:), '-.rs','LineWidth',1.5);
hold on;
plot( SNR, MI(6,:), '--k*','LineWidth',1.5);
hold on;
plot( SNR, MI(7,:), '--bo','LineWidth',1.5);
hold on;
plot( SNR, MI(8,:), '--rs','LineWidth',1.5);

set(hf,'position',[0,0,760,468])
grid on;
legend('MRC,full CSI','ZF,full CSI','LS,N=5M','MRC,channel estimation,N=5M','ZF,channel estimation,N=5M','LS,N=50M','MRC,channel estimation,N=50M','ZF,channel estimation,N=50M')
xlabel('\fontsize{14}SNR(dB)');
ylabel('\fontsize{14}Mutual information per user (bit/channel use)');