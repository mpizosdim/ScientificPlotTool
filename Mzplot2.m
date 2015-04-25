function Mzplot2(varargin)
% Function to create plots intended for use in scientific
% papers.
%---------------Explanation-------------
% MZPLOT2(X1,Y1,X2,Y2,...,X_N,Y_N,Legend1,Legend2,...,Legend_N,labelX,labelY,title,exportFigure,positionOfLegend,text,positionOfText,ColoredPlot,MarkerStylePlot)
% exportFigure: 0 or 1 value, the plot is exported in eps format. It is
% recommended generally to export to eps format when the plot is intended
% to be used for pdf texts. When the value is 1 the figure size takes the
% size of the screen for better exported quality. The figure is exported
% with the name Figure.eps
% positionOfLegend: 1 for northwest, 2 for northeast, 3 for
% southwest, 4 for southeast
% text: additional text for the plot
% positionOfText: 1 for northwest, 2 for northeast, 3 for
% southwest, 4 for southeast
% ColoredPlot: 0 for black&plot, 1 for colored plot
% MarkerStylePlot: 0 for not marker style, 1 for marker style.Marker style is often used when having experimental data 
%-------------Example 1------------------
% black and white plot,with text, without exporting the plot
% x = linspace(-2*pi,2*pi);
% y1 = sin(x);
% y2 = cos(x);
% y3 = cos(x).^2;
% Mzplot2(x,y1,x,y2,x,y3,'y = sin(x)','y = cos(x)','y = cos(x)^2','x','y','sine and cosine values of x',0,3,'This is a text',4,0,0);
%-------------Example 2----------------
% black and white plot with marker style, without text and title and the plot is
% exported.
% x = -pi:pi/5:pi;
% y1 = tan(sin(x)) - sin(tan(x));
% y2 = tan(sin(x)) - 2*sin(tan(x));
% y3 = 2*tan(sin(x)) - sin(tan(x));
% Mzplot2(x,y1,x,y2,x,y3,'tan(sin(x)) - sin(tan(x))','tan(sin(x)) - 2*sin(tan(x))','2*tan(sin(x)) - sin(tan(x))','x','y','',1,1,'',4,0,1);
%-------------Example 3----------------
% Color plot. The figure is not exported.Without text and title.
% x = -2:0.1:2;
% y1 = x.^2;
% y2 = 2*x.^2;
% Mzplot2(x,y1,x,y2,'x^2','2*x^2','x','y','',0,1,'',4,1,0);
%
%------------notes---------------------
% note: the plots generated are in black and white to fullfil some
% requirments in specific scientific plots. The difference can be
% understood when exporting the file and viewing it in your pdf.
% note2: It's up to you to choose the size of the letters.But the one
% specified in this code work good for articles/thesis/assignment plots.
% note3: the function is recommended to be used to generate the final plot in order to be
% used for a document.
% 
%--------------------------------------
N = (nargin-9)/3;
if varargin{(((2*(nargin-9)/3)+1)+N+8)}==0
    lineStyle = {'--','',':','','-.','','-'};%change line style if you wish.Other options used for dot style:{':gs','','--^','','-*','',':o'};
else
    lineStyle = {':gs','','--^','','-*','',':o'};
end

figure
for ii=1:2:2*N
    plot(varargin{ii},varargin{ii+1},lineStyle{ii},'MarkerSize',10)
    hold on
end
if varargin{(((2*(nargin-9)/3)+1)+N+7)}==0
    set(findobj('Type','line'),'Color','k')
end
set(findobj('Type','line'),'LineWidth',1.5)

legends = varargin(((2*(nargin-9)/3)+1):(((2*(nargin-9)/3)+1)+N-1));
h_legend=legend(legends{:});

switch varargin{(((2*(nargin-9)/3)+1)+N+4)}
    case 1
        set(h_legend,'Location','northwest')
    case 2
        set(h_legend,'Location','northeast')
    case 3
        set(h_legend,'Location','southwest')
    case 4
        set(h_legend,'Location','southeast')
end


xlabel(varargin{(((2*(nargin-9)/3)+1)+N)})
h_xlabel=get(gca,'Xlabel');
set(h_xlabel,'FontSize',19);

ylabel(varargin{(((2*(nargin-9)/3)+1)+N+1)})
h_ylabel=get(gca,'Ylabel');
set(h_ylabel,'FontSize',19);

if varargin{(((2*(nargin-9)/3)+1)+N+2)}~=0
    title(varargin{(((2*(nargin-9)/3)+1)+N+2)})
    h_title=get(gca,'title');
    set(h_title,'FontSize',15,'FontWeight','Bold');
end

grid on

set(gca,'fontsize',17)
set(h_legend,'FontSize',18)
set(h_legend,'EdgeColor',[0.99 0.99 0.99])


xlim([min(varargin{1}) max(varargin{1})])

RangeX = linspace(min(varargin{1}),max(varargin{1}),10);
RangeY = linspace(min(min(varargin{2}),min(varargin{4})),max(max(varargin{2}),max(varargin{4})),10);
Text = cellstr(varargin{(((2*(nargin-9)/3)+1)+N+5)});
switch varargin{(((2*(nargin-9)/3)+1)+N+6)}
    case 1
        for ii=1:length(Text)
            text(RangeX(2),RangeY(10-ii),Text(ii),'FontSize',16);
        end
    case 2
        for ii=1:length(Text)
            text(RangeX(9),RangeY(10-ii),Text(ii),'FontSize',16);
        end
    case 3
        Text2 = Text(end:-1:1);
        for ii=length(Text):-1:1
            text(RangeX(2),RangeY(ii+1),Text2(ii),'FontSize',16);
        end
    case 4
        Text2 = Text(end:-1:1);
        for ii=length(Text):-1:1
            text(RangeX(9),RangeY(ii+1),Text2(ii),'FontSize',16);
        end
end

if varargin{(((2*(nargin-9)/3)+1)+N+3)}==1
    scrsz = get(0,'ScreenSize');
    set(gcf,'position',scrsz);
    print -depsc Figure.eps
end

