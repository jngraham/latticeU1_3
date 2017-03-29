% U(1) Lattice Gauge Theory | James Graham

% Data Analysis

Folders = {'18_18_24', '22_22_36', '28_28_40'};
beta = {'2.0', '2.2', '2.3'};
beta_num = [2.0, 2.2, 2.3];

% selects which folder to take data from / write figures to
for i = 1:3
    
    avg_p = figure('Name', 'Average Plaquette', 'NumberTitle', 'off');
    mplus = figure('Name', 'm0++', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    mminus = figure('Name', 'm0--', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_re = figure('Name', 'Flux Tube (Real Part)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_im = figure('Name', 'Flux Tube (Imaginary Part)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    
%     selects which beta to take data from / will put all betas side by
%     side

    
    for j = 1:3
        
        f_plaquette_name = strcat(Folders{1,i},'/plaquette_beta',beta{1,j},'.csv');
        temp = (csvread(f_plaquette_name,1));
        avg_plaquette_data = temp(:,2);
        
        figure(avg_p)
        boxplot(avg_plaquette_data,'Whisker',0.9529);
        set(findobj(gcf,'-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
        xlabel(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',24)
        ylabel('$$\langle\cos U_p\rangle$$','Interpreter','latex','FontSize',24)
        set(gca,'YTickLabelRotation',90)
        set(gca,'XTickLabel',{' '})
        saveas(avg_p,strcat('figures/',Folders{1,i},'/plaquette_beta',beta{1,j},'.png'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        f_mplus_name = strcat(Folders{1,i},'/mplus_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_mplus_name,1);
%         this gets rid of the sample number and the newline character
        mplus_data = temp(:,2:(end-1));
        
%         for all further plots
        T = length(mplus_data(1,:)) - 1;
        time = 0:1:T;
        
        N_s = length(mplus_data(:,1));
        
        figure(mplus)
        subplot(1,3,j)
        for k = 1:N_s
            plot(time,mplus_data(k,:),'bx')
            xlim([0 T])
            hold on;
        end
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\langle\Phi^\dagger(t)\Phi(0)\rangle$$','Interpreter','latex','FontSize',16)
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

        f_mminus_name = strcat(Folders{1,i},'/mminus_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_mminus_name,1);
        mminus_data = temp(:,2:(end-1));
        
        figure(mminus)
        subplot(1,3,j)
        for k = 1:N_s
            plot(time,mminus_data(k,:),'bx')
            xlim([0 T])
            hold on;
        end
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\langle\Phi^\dagger(t)\Phi(0)\rangle$$','Interpreter','latex','FontSize',16)
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        f_flux_re_name = strcat(Folders{1,i},'/flux_re_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_flux_re_name,1);
        flux_re_data = temp(:,2:(end-1));
        
        figure(flux_re)
        subplot(1,3,j)
        for k = 1:N_s
            plot(time,flux_re_data(k,:),'bx')
            xlim([0 T])
            hold on;
        end
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\textrm{Re}\left(\langle\Phi^\dagger(t)\Phi(0)\rangle\right)$$','Interpreter','latex','FontSize',16)
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        f_flux_im_name = strcat(Folders{1,i},'/flux_im_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_flux_im_name,1);
        flux_im_data = temp(:,2:(end-1));
        
        figure(flux_im)
        subplot(1,3,j)
        for k = 1:N_s
            plot(time,flux_im_data(k,:),'bx')
            xlim([0 T])
            hold on;
        end
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\textrm{Im}\left(\langle\Phi^\dagger(t)\Phi(0)\rangle\right)$$','Interpreter','latex','FontSize',16)
        
%         close all;
        
    end
   
    
    print(mplus,strcat('figures/',Folders{1,i},'/mplus.pdf'),'-dpdf','-r300')
    print(mminus,strcat('figures/',Folders{1,i},'/mminus.pdf'),'-dpdf','-r300')
    print(flux_re,strcat('figures/',Folders{1,i},'/flux_re.pdf'),'-dpdf','-r300')
    print(flux_im,strcat('figures/',Folders{1,i},'/flux_im.pdf'),'-dpdf','-r300')
    
    close all;
end

    clear;