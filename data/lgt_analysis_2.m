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
tend = 10;

% critical t value for a two-sided 99% confidence interval
t_crit = 2.797;

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
    
    mplus = figure('Name', 'm0++', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    mminus = figure('Name', 'm0--', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_re = figure('Name', 'Flux Tube (Real Part)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_im = figure('Name', 'Flux Tube (Imaginary Part)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_abs = figure('Name', 'Flux Tube (Norm)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);

%     selects which beta to take data from / will put all betas side by
%     side
    for j = 1:3
        
        temp_mplus_mass = [];
        
        temp_mminus_mass = [];
        
        temp_flux_re_energy = [];
        
        temp_flux_im_energy = [];
        
        f_mplus_name = strcat(Folders{1,i},'/mplus_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_mplus_name,1);
%         this gets rid of the sample number and the newline character
        mplus_data = temp(:,2:(end-1));
        
%         for all further plots
        T = length(mplus_data(1,:));
        
%         if the number of times is, for example, 24, we want time to range
%         from 0 to 23
        time = 0:1:(T-1);
        tsample = time(tstart:tend)';
        t_fit_sample = ((tstart-1):0.1:(tend-1))';
        
%         specifics for this observable
        mplus_avg = mean(mplus_data);
        mplus_std = std(mplus_data);
%         5 = sqrt(25)
        mplus_err = t_crit*mplus_std/5;
        
%         mplus_sample = mplus_avg(tstart:tend)'-min(mplus_avg(tstart:tend))*ones(tend-tstart+1,1);
%         mplus_fit = fit(tsample, mplus_sample, 'exp1');
%         mplus_y = mplus_fit(t_fit_sample)+min(mplus_avg(tstart:tend))*ones(length(t_fit_sample),1);
        
        figure(mplus)
        subplot(1,3,j)
        hold on;
        errorbar(time(2:end),mplus_avg(2:end),mplus_err(2:end),'bo');
%         plot(t_fit_sample,mplus_y,'r','LineWidth',2)
        xlim([0 T])
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\langle\Phi^\dagger(t)\Phi(0)\rangle$$','Interpreter','latex','FontSize',16)
        
        mplus_mass = [mplus_mass temp_mplus_mass];
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

        f_mminus_name = strcat(Folders{1,i},'/mminus_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_mminus_name,1);
        mminus_data = temp(:,2:(end-1));
        
        mminus_avg = mean(mminus_data);
        mminus_std = std(mminus_data);
%         5 = sqrt(25)
        mminus_err = t_crit*mminus_std/5;
        
%         mminus_sample = mminus_avg(tstart:tend)';
%         mminus_fit = fit(tsample, mminus_sample, 'exp1');
%         mminus_y = mminus_fit(t_fit_sample);
        
        figure(mminus)
        subplot(1,3,j)
        hold on;
        errorbar(time(2:end),mminus_avg(2:end),mminus_err(2:end),'bo')
%         plot(t_fit_sample,mminus_y,'r','LineWidth',2)
        xlim([0 T])
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\langle\Phi^\dagger(t)\Phi(0)\rangle$$','Interpreter','latex','FontSize',16)
        
        mminus_mass = [mminus_mass temp_mminus_mass];
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        f_flux_re_name = strcat(Folders{1,i},'/flux_re_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_flux_re_name,1);
        flux_re_data = temp(:,2:(end-1));
        
        flux_re_avg = mean(flux_re_data);
        flux_re_std = std(flux_re_data);
%         5 = sqrt(25)
        flux_re_err = t_crit*flux_re_std/5;
        
%         flux_re_sample = flux_re_avg(tstart:tend)';
%         flux_re_fit = fit(tsample, flux_re_sample, 'exp1');
%         flux_re_y = flux_re_fit(t_fit_sample);
        
        figure(flux_re)
        subplot(1,3,j)
        hold on;
        errorbar(time(2:end),flux_re_avg(2:end),flux_re_err(2:end),'bo')
%         plot(t_fit_sample,flux_re_y,'r','LineWidth',2)
        xlim([0 T])
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\textrm{Re}\left(\langle\Phi^\dagger(t)\Phi(0)\rangle\right)$$','Interpreter','latex','FontSize',16)
        
        flux_re_energy = [flux_re_energy temp_flux_re_energy];
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        f_flux_im_name = strcat(Folders{1,i},'/flux_im_beta',num2str(beta{1,j}),'.csv');
        temp = csvread(f_flux_im_name,1);
        flux_im_data = temp(:,2:(end-1));
        
        flux_im_avg = mean(flux_im_data);
        flux_im_std = std(flux_im_data);
%         5 = sqrt(25)
        flux_im_err = t_crit*flux_im_std/5;
        
%         flux_im_sample = flux_im_avg(tstart:tend)';
%         flux_im_fit = fit(tsample, flux_im_sample, 'exp1');
%         flux_im_y = flux_im_fit(t_fit_sample);
        
        figure(flux_im)
        subplot(1,3,j)
        hold on;
        errorbar(time(2:end),flux_im_avg(2:end),flux_im_err(2:end),'bo')
%         plot(t_fit_sample,flux_im_y,'r','LineWidth',2)
        xlim([0 T])
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\textrm{Im}\left(\langle\Phi^\dagger(t)\Phi(0)\rangle\right)$$','Interpreter','latex','FontSize',16)
        
%         flux_im_energy = [flux_im_energy temp_flux_im_energy];
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        flux_abs_data = (flux_re_data.^2+flux_im_data.^2).^(1/2);
        
        flux_abs_avg = mean(flux_abs_data);
        flux_abs_std = std(flux_abs_data);
%         5 = sqrt(25)
        flux_abs_err = t_crit*flux_abs_std/5;
        
%         flux_im_sample = flux_im_avg(tstart:tend)';
%         flux_im_fit = fit(tsample, flux_im_sample, 'exp1');
%         flux_im_y = flux_im_fit(t_fit_sample);
        
        figure(flux_abs)
        subplot(1,3,j)
        hold on;
        errorbar(time(2:end),flux_abs_avg(2:end),flux_abs_err(2:end),'bo')
%         plot(t_fit_sample,flux_im_y,'r','LineWidth',2)
        xlim([0 T])
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$|\langle\Phi^\dagger(t)\Phi(0)\rangle\|$$','Interpreter','latex','FontSize',16)
        
    end
   
    
%     save all figures to file, save all summaries to file (as .mat with no column names...)
%     summaryname = strcat('summary/', Folders{1,i});
%     save(summaryname, 'avg_plaquette', 'mplus_mass', 'mminus_mass', 'flux_re_energy', 'flux_im_energy');

%     save(strcat('summary/', Folders{1,i}, '_fits'), 'avg_plaquette', 'mplus_fit', 'mminus_fit', 'flux_re_fit', 'flux_im_fit')
    
    print(mplus,strcat('figures/',Folders{1,i},'/mplus_bars.pdf'),'-dpdf','-r300')
    print(mminus,strcat('figures/',Folders{1,i},'/mminus_bars.pdf'),'-dpdf','-r300')
    print(flux_re,strcat('figures/',Folders{1,i},'/flux_re_bars.pdf'),'-dpdf','-r300')
    print(flux_im,strcat('figures/',Folders{1,i},'/flux_im_bars.pdf'),'-dpdf','-r300')
    print(flux_abs,strcat('figures/',Folders{1,i},'/flux_abs_bars.pdf'),'-dpdf','-r300')
    
    close all;
end

    clear;