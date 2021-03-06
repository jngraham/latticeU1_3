% U(1) Lattice Gauge Theory | James Graham

% Data Analysis

Folders = {'18_18_24', '22_22_36', '28_28_40'};
% Folders = {'10_10_10'};
beta = {'2.0', '2.2', '2.3'};
beta_num = [2.0, 2.2, 2.3];

N_s = 25;

warning('off','all')
warning

% start fitting at time = 1, 2nd entry of time vector
tstart = 2;
% stop fitting at T/2-tcutoff
tcutoff = 3;

% the idea for writing the summary data is to have one file for each
% observable, in the folder 'summary'. We'll have a separate column for
% each size of lattice and in each row we will have the sample number

% generically we will fit the exponential on times from 1 to 

    
% selects which folder to take data from / write figures to
for i = 1:3
    
    mplus_mass = [];
    mminus_mass = [];
    flux_re_energy = [];
    flux_im_energy = [];
    
    avg_p = figure('Name', 'Average Plaquette', 'NumberTitle', 'off');
    mplus = figure('Name', 'm0++', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    mminus = figure('Name', 'm0--', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_re = figure('Name', 'Flux Tube (Real Part)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_im = figure('Name', 'Flux Tube (Imaginary Part)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    
%     selects which beta to take data from / will put all betas side by
%     side

    
    for j = 1:3
        
        temp_mplus_mass = [];
        
        temp_mminus_mass = [];
        
        temp_flux_re_energy = [];
        
        temp_flux_im_energy = [];
        
        f_plaquette_name = strcat(Folders{1,i},'/plaquette_beta',beta{1,j},'.csv');
        temp = (csvread(f_plaquette_name,1));
        avg_plaquette_data = temp(:,2);
%         
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
        T = length(mplus_data(1,:));
        
%         if the number of times is, for example, 24, we want time to range
%         from 0 to 23
        time = 0:1:(T-1);
        
        figure(mplus)
        subplot(1,3,j)
        
        for k = 1:N_s
            hold on;
            plot(time,mplus_data(k,:),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
            hold on;
            tsample = time((tstart-1):(T/2-tcutoff))';
            ysample = mplus_data(k,(tstart-1):(T/2-tcutoff))';
            mplus_fit = fit(tsample,ysample,'exp1');
            coeffs = coeffvalues(mplus_fit);
            cinterval = confint(mplus_fit,0.95);
            temp_mplus_mass = [temp_mplus_mass; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(mplus_fit,tsample,ysample)
            legend('off')
            xlim([0 T])
        end
        
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\langle\Phi^\dagger(t)\Phi(0)\rangle$$','Interpreter','latex','FontSize',16)
        
        mplus_mass = [mplus_mass temp_mplus_mass];
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

        f_mminus_name = strcat(Folders{1,i},'/mminus_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_mminus_name,1);
        mminus_data = temp(:,2:(end-1));
        
        figure(mminus)
        subplot(1,3,j)
        for k = 1:N_s
            hold on;
            plot(time,mminus_data(k,:),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
            hold on;
            tsample = time(tstart:(T/2-tcutoff))';
            ysample = mminus_data(k,tstart:(T/2-tcutoff))';
            mminus_fit = fit(tsample,ysample,'exp1');
            coeffs = coeffvalues(mminus_fit);
            cinterval = confint(mminus_fit,0.95);
            temp_mminus_mass = [temp_mminus_mass; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(mminus_fit,tsample,ysample)
            legend('off')
            xlim([0 T])
        end
        
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\langle\Phi^\dagger(t)\Phi(0)\rangle$$','Interpreter','latex','FontSize',16)
        
        mminus_mass = [mminus_mass temp_mminus_mass];
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        f_flux_re_name = strcat(Folders{1,i},'/flux_re_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_flux_re_name,1);
        flux_re_data = temp(:,2:(end-1));
        
        figure(flux_re)
        subplot(1,3,j)
        for k = 1:N_s
            hold on;
            plot(time,flux_re_data(k,:),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
            hold on;
            tsample = time(tstart:(T/2-tcutoff))';
            ysample = flux_re_data(k,tstart:(T/2-tcutoff))';
            flux_re_fit = fit(tsample,ysample,'exp1');
            coeffs = coeffvalues(flux_re_fit);
            cinterval = confint(flux_re_fit,0.95);
            temp_flux_re_energy = [temp_flux_re_energy; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(flux_re_fit,tsample,ysample)
            legend('off')
            xlim([0 T])
        end
        
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\textrm{Re}\left(\langle\Phi^\dagger(t)\Phi(0)\rangle\right)$$','Interpreter','latex','FontSize',16)
        
        flux_re_energy = [flux_re_energy temp_flux_re_energy];
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        f_flux_im_name = strcat(Folders{1,i},'/flux_im_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_flux_im_name,1);
        flux_im_data = temp(:,2:(end-1));
        
        figure(flux_im)
        subplot(1,3,j)
        for k = 1:N_s
            hold on;
            plot(time,flux_im_data(k,:),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
           hold on;
            tsample = time(tstart:(T/2-tcutoff))';
            ysample = flux_im_data(k,tstart:(T/2-tcutoff))';
            flux_im_fit = fit(tsample,ysample,'exp1');
            coeffs = coeffvalues(flux_im_fit);
            cinterval = confint(flux_im_fit,0.95);
            temp_flux_im_energy = [temp_flux_im_energy; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(flux_im_fit,tsample,ysample)
            legend('off')
            xlim([0 T])
        end
        
        
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\textrm{Im}\left(\langle\Phi^\dagger(t)\Phi(0)\rangle\right)$$','Interpreter','latex','FontSize',16)
        
        flux_im_energy = [flux_im_energy temp_flux_im_energy];
        
    end
   
    
%     save all figures to file, save all summaries to file (as .mat with no column names...)
    summaryname = strcat('summary/', Folders{1,i});
    save(summaryname, 'avg_plaquette_data', 'mplus_mass', 'mminus_mass', 'flux_re_energy', 'flux_im_energy');

    print(mplus,strcat('figures/',Folders{1,i},'/mplus.pdf'),'-dpdf','-r300')
    print(mminus,strcat('figures/',Folders{1,i},'/mminus.pdf'),'-dpdf','-r300')
    print(flux_re,strcat('figures/',Folders{1,i},'/flux_re.pdf'),'-dpdf','-r300')
    print(flux_im,strcat('figures/',Folders{1,i},'/flux_im.pdf'),'-dpdf','-r300')
    
    close all;
end

    clear;