function Mzmesh2(varargin)
% MZMESH2 mesh plot for use in scientific documents.Export is done in eps
% file for better quality.
% MZMESH2(X,Y,Z,mesh gradient,xlabel,ylabel,zlabel,title,export)
% mesh gradient take values: 0 for not ploting the gradient of the data, 1
% for ploting the gradient of the input data.
% export : 0 for not exporting the figure in eps format, 1 for exporting the
% figure in eps format.

X= varargin{1};
Y=varargin{2};
Z = varargin{3};
figure;
if varargin{4}==1
    G=gradient(Z);
    h=mesh(X,Y,Z,abs(G));
    set(h,'FaceColor','interp')
    set(h,'EdgeColor','k')
else
    h=mesh(X,Y,Z);
    set(h,'FaceColor','interp')
    set(h,'EdgeColor',[0.2 0.2 0.2])
end

h2 = colorbar('northoutside');
set(h2,'fontsize',13);

title(varargin{8})
h_title=get(gca,'title');
set(h_title,'FontSize',15,'FontWeight','Bold')

xlabel(varargin{5})
h_xlabel=get(gca,'Xlabel');
set(h_xlabel,'FontSize',18);

ylabel(varargin{6})
h_ylabel=get(gca,'Ylabel');
set(h_ylabel,'FontSize',18);

zlabel(varargin{7})
h_zlabel=get(gca,'Zlabel');
set(h_zlabel,'FontSize',18);

set(gca,'fontsize',16)

if varargin{9}==1
    scrsz = get(0,'ScreenSize');
    set(gcf,'position',scrsz);
    print -depsc Figure.eps
end
