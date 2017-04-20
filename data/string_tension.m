
Lx = [18; 22; 28];
x = linspace(18,28);

beta0 = [1.292; 1.757; 2.584];
beta2 = [0.755; 1.042; 1.594];
beta3 = [0.612; 0.848; 1.292];

for j = 1:3
    beta0(j) = beta0(j)+pi/(6*Lx(j));
    beta2(j) = beta2(j)+pi/(6*Lx(j));
    beta3(j) = beta3(j)+pi/(6*Lx(j));
end

st = figure('Name', 'Flux Tube Energies', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[14 12],'PaperPosition', [0,0,14,12]);
hold on;

scatter(Lx,beta0,40,'r','o')
scatter(Lx,beta2,40,'k','d')
scatter(Lx,beta3,40,'b','x')

[fit0,S0]=polyfit(Lx,beta0,1);
y0=polyval(fit0,x);

[fit2,S2]=polyfit(Lx,beta2,1);
y2=polyval(fit2,x);

[fit3,S3]=polyfit(Lx,beta3,1);
y3=polyval(fit3,x);

b0=Lx\beta0;
pts0=Lx*b0;
chi0=sum((beta0-pts0).^2./pts0);

b2=Lx\beta2;
pts2=Lx*b2;
chi2=sum((beta2-pts2).^2./pts2);

b3=Lx\beta3;
pts3=Lx*b3;
chi3=sum((beta3-pts3).^2./pts3);

plot(x,0.0842*x,'r-')
plot(x,y0,'r--')
plot(x,0.0513*x,'k-')
plot(x,y2,'k--')
plot(x,.0417*x,'b-')
plot(x,y3,'b--')

xlim([16 30])
ylim([0 3.5])
l = legend('$$\beta=2.0$$','$$\beta=2.2$$','$$\beta=2.3$$');
set(l,'Interpreter','latex','FontSize',14,'Units','centimeters','Position',[14 12 4 2])
% set(l,'Position',[0,0,3,2])
xlabel('$$L_x$$','Interpreter','latex','FontSize',16)
ylabel('$$E_f(L_x)+\pi/6L_x$$','Interpreter','latex','FontSize',16)

print(st,strcat('figures/string_tension.pdf'),'-dpdf','-r300')
