% U(1) Lattice Gauge Theory | James Graham

% Data Analysis

Folders = ['18_18_24'; '22_22_36'; '28_28_40'];
beta = ['2.0'; '2.2'; '2.3'];

for i = 1:3
    
    for j = 1:3
        
         f_plaquette_name = strcat(Folders(i),'/plaquette_beta',beta(j));
%         f_plaquette = open(f_plaquette_name);
        
%         f_mplus = open(strcat(Folders(i),'/mplus_beta',num2str(beta(j)),'.csv'),'r');
%         f_mminus = open(strcat(Folders(i),'/mminus_beta',num2str(beta(j))),'r');
%         f_flux_re = open(strcat(Folders(i),'/flux_re_beta',num2str(beta(j))),'r');
%         f_flux_im = open(strcat(Folders(i),'/flux_im_beta',num2str(beta(j))),'r');
       
        a=1;
        
    end
end