
Lx = [18 22 28];
Lx1 = [18 22];

beta0 = [1.08 0.726; 1.08+0.268 0.726+0.395; 1.08-0.268 0.726-0.395]
beta2 = [0.657 0.832; 0.657+.129 0.832+0.212; 0.657-0.129 0.832-0.212]
beta3 = [0.482 0.702 0.516; 0.482+0.0623 0.702+0.119 0.516+0.157; 0.482-0.0623 0.702-0.119 0.516-0.157]

for i = 1:2
    beta0(:,i) = beta0(:,i)+pi/(6*Lx1(i));
    beta2(:,i) = beta2(:,i)+pi/(6*Lx1(i));
end
for j = 1:3
    beta3(:,i) = beta3(:,i)+pi/(6*Lx1(i));
end

st = figure('Name', 'Flux Tube Energies', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[14 12],'PaperPosition', [0,0,14,12]);
hold on;
for j = 1:3
    scatter(Lx1,beta0(j,:),40,'r','o')
    scatter(Lx1,beta2(j,:),40,'k','d')
    scatter(Lx,beta3(j,:),40,'b','x')
end
xlim([16 30])
l = legend('$$\beta=2.0$$','$$\beta=2.2$$','$$\beta=2.3$$');
set(l,'Interpreter','latex','FontSize',14,'Units','centimeters','Position',[14 12 4 2])
% set(l,'Position',[0,0,3,2])
xlabel('$$L_x$$','Interpreter','latex','FontSize',16)
ylabel('$$E_f(L_x)+\pi/6L_x$$','Interpreter','latex','FontSize',16)

% beta0st = [];
% beta2st = [];
% beta3st = [];
% 
% for i = 1:3
%     for j = 1:2
%         beta0st = [beta0st; beta0(i,j)/Lx1(j)];
%         beta2st = [beta2st; beta2(i,j)/Lx1(j)];
%     end
%     for j = 1:3
%         beta3st = [beta3st; beta3(i,j)/Lx(j)];
%     end
% end

print(st,strcat('figures/string_tension.pdf'),'-dpdf','-r300')
