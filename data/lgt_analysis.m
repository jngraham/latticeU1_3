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
% stop fitting time tcutoff-1
tcutoff = 10;

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
    flux_abs_energy = [];
    avg_plaquette = [];
    
    avg_p = figure('Name', 'Average Plaquette', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[12 12],'PaperPosition', [0,0,13,12]);
    mplus = figure('Name', 'm0++', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    mminus = figure('Name', 'm0--', 'NumberTitle', 'off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_re = figure('Name', 'Flux Tube (Real Part)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_im = figure('Name', 'Flux Tube (Imaginary Part)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);
    flux_abs = figure('Name', 'Flux Tube (Norm)', 'NumberTitle','off','PaperUnits','centimeters','PaperSize',[24 8],'PaperPosition',[-2,0.5,28,7]);

    
%     selects which beta to take data from / will put all betas side by
%     side
    for j = 1:3
        
        f_plaquette_name = strcat(Folders{1,i},'/plaquette_beta',beta{1,j},'.csv');
        temp = (csvread(f_plaquette_name,1));
%         avg_plaquette_data = temp(:,2);
        avg_plaquette = [avg_plaquette temp(:,2)];
        
    end
%         
    figure(avg_p)
    boxplot(avg_plaquette,'Whisker',0.9529);
    set(findobj(gcf,'-regexp','Tag','\w*Whisker'),'LineStyle','-','Color','k')
    xlabel('$$\beta$$','Interpreter','latex','FontSize',24)
    ylabel('$$\langle\cos U_p\rangle$$','Interpreter','latex','FontSize',24)
    set(gca,'YTickLabelRotation',90)
    set(gca,'XTickLabel',{'2.0', '2.2', '2.3'})
%     saveas(avg_p,strcat('figures/',Folders{1,i},'/plaquette_beta',beta{1,j},'.png'))
    print(avg_p,strcat('figures/',Folders{1,i},'/plaquette.pdf'),'-dpdf','-r300')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    for j = 1:3
        
        temp_mplus_mass = [];
        temp_mminus_mass = [];
        temp_flux_re_energy = [];
        temp_flux_im_energy = [];
        temp_flux_abs_energy = [];
        
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
        
        tstart = 2;
        tcutoff = 6;
        
        for k = 1:N_s
            hold on;
            plot(time(2:end),mplus_data(k,2:end),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
            hold on;
            tsample = time(tstart:tcutoff)';
            t_fit_sample = ((tstart-1):0.1:(tcutoff-1))';
            ysample = mplus_data(k,tstart:tcutoff)'-min(mplus_data(k,tstart:tcutoff))*ones(tcutoff-tstart+1,1);
            mplus_fit = fit(tsample,ysample,'exp1');
            y = mplus_fit(t_fit_sample)+min(mplus_data(k,tstart:tcutoff))*ones(length(t_fit_sample),1);
            
            coeffs = coeffvalues(mplus_fit);
            cinterval = confint(mplus_fit,0.99);
            temp_mplus_mass = [temp_mplus_mass; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(t_fit_sample,y,'r')
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
        
        if i == 1
            tcutoff = 11;
        else
            tcutoff = 15;
        end
        
        figure(mminus)
        subplot(1,3,j)
        for k = 1:N_s
            hold on;
            plot(time(2:end),mminus_data(k,2:end),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
            hold on;
            tsample = time(tstart:tcutoff)';
            t_fit_sample = ((tstart-1):0.1:(tcutoff-1))';
            ysample = mminus_data(k,tstart:tcutoff)'-min(mminus_data(k,tstart:tcutoff))*ones(tcutoff-tstart+1,1);
            mminus_fit = fit(tsample,ysample,'exp1');
            y = mminus_fit(t_fit_sample)+min(mminus_data(k,tstart:tcutoff))*ones(length(t_fit_sample),1);
            
            coeffs = coeffvalues(mminus_fit);
            cinterval = confint(mminus_fit,0.99);
            temp_mminus_mass = [temp_mminus_mass; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(t_fit_sample,y,'r')
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
        
        if j == 1
            tcutoff = 7;
        else
            if i == 1
                tcutoff = 11;
            else
                tcutoff = 9;
            end
        end
        
        figure(flux_re)
        subplot(1,3,j)
        for k = 1:N_s
            hold on;
            plot(time(2:end),flux_re_data(k,2:end),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
            hold on;
            tsample = time(tstart:tcutoff)';
            t_fit_sample = ((tstart-1):0.1:(tcutoff-1))';
            ysample = flux_re_data(k,tstart:tcutoff)'-min(flux_re_data(k,tstart:tcutoff))*ones(tcutoff-tstart+1,1);
            flux_re_fit = fit(tsample,ysample,'exp1');
            y = flux_re_fit(t_fit_sample)+min(flux_re_data(k,tstart:tcutoff))*ones(length(t_fit_sample),1);
            
            coeffs = coeffvalues(flux_re_fit);
            cinterval = confint(flux_re_fit,0.99);
            temp_flux_re_energy = [temp_flux_re_energy; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(t_fit_sample,y,'r')
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
        
        tcutoff = 10;
        
        figure(flux_im)
        subplot(1,3,j)
        for k = 1:N_s
            hold on;
            plot(time(2:end),flux_im_data(k,2:end),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
            hold on;
            tsample = time(tstart:tcutoff)';
            t_fit_sample = ((tstart-1):0.1:(tcutoff-1))';
            ysample = flux_im_data(k,tstart:tcutoff)'-min(flux_im_data(k,tstart:tcutoff))*ones(tcutoff-tstart+1,1);
            flux_im_fit = fit(tsample,ysample,'exp1');
            y = flux_im_fit(t_fit_sample)+min(flux_im_data(k,tstart:tcutoff))*ones(length(t_fit_sample),1);
            
            coeffs = coeffvalues(flux_im_fit);
            cinterval = confint(flux_im_fit,0.99);
            temp_flux_im_energy = [temp_flux_im_energy; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(t_fit_sample,y,'r')
            legend('off')
            xlim([0 T])
        end
        
        
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$\textrm{Im}\left(\langle\Phi^\dagger(t)\Phi(0)\rangle\right)$$','Interpreter','latex','FontSize',16)
        
        flux_im_energy = [flux_im_energy temp_flux_im_energy];
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

        flux_abs_data = (flux_re_data.^2+flux_im_data.^2).^(1/2);
        
        tstart = 2;
        
        if j == 1
            tcutoff = 7;
        else
            if i == 1
                tcutoff = 11;
            else
                tcutoff = 9;
            end
        end
        
        figure(flux_abs)
        subplot(1,3,j)
        for k = 1:N_s
            hold on;
            plot(time(2:end),flux_abs_data(k,2:end),'b.')
            legend('off')
            xlim([0 T])
        end
        for k = 1:N_s
            hold on;
            tsample = time(tstart:tcutoff)';
            t_fit_sample = ((tstart-1):0.1:(tcutoff-1))';
            ysample = flux_abs_data(k,tstart:tcutoff)'-min(flux_abs_data(k,tstart:tcutoff))*ones(tcutoff-tstart+1,1);
            flux_abs_fit = fit(tsample,ysample,'exp1');
            y = flux_abs_fit(t_fit_sample)+min(flux_abs_data(k,tstart:tcutoff))*ones(length(t_fit_sample),1);
            
            coeffs = coeffvalues(flux_abs_fit);
            cinterval = confint(flux_abs_fit,0.99);
            temp_flux_abs_energy = [temp_flux_abs_energy; [-coeffs(2), -cinterval(2,2), -cinterval(1,2)]];
            plot(t_fit_sample(1:end),y(1:end),'r')
            legend('off')
            xlim([0 T])
        end        
        
        set(gca,'YTickLabelRotation',0)
        title(strcat('$$\beta=\,$$',' ',beta{1,j}),'Interpreter','latex','FontSize',16)
        xlabel('$$t$$','Interpreter','latex','FontSize',16)
        ylabel('$$|\langle\Phi^\dagger(t)\Phi(0)\rangle\|$$','Interpreter','latex','FontSize',16)
        
        flux_abs_energy = [flux_abs_energy temp_flux_abs_energy];
    end
   
    
%     save all figures to file, save all summaries to file (as .mat with no column names...)
    summaryname = strcat('summary/', Folders{1,i});
    save(summaryname, 'avg_plaquette', 'mplus_mass', 'mminus_mass', 'flux_re_energy', 'flux_im_energy', 'flux_abs_energy');

    print(mplus,strcat('figures/',Folders{1,i},'/mplus.pdf'),'-dpdf','-r300')
    print(mminus,strcat('figures/',Folders{1,i},'/mminus.pdf'),'-dpdf','-r300')
    print(flux_re,strcat('figures/',Folders{1,i},'/flux_re.pdf'),'-dpdf','-r300')
    print(flux_im,strcat('figures/',Folders{1,i},'/flux_im.pdf'),'-dpdf','-r300')
    print(flux_abs,strcat('figures/',Folders{1,i},'/flux_abs.pdf'),'-dpdf','-r300')
    
    close all;
end

    clear;