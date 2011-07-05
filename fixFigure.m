% Script which changes the properties of the current figure to presentation-quality
function fixFigure(fontSize,lineWidth,addText)

if nargin < 1 || isempty(fontSize)
    fontSize = 14;
end
if nargin < 2 || isempty(lineWidth)
    lineWidth = 1.5;
end
fontName = 'Arial';
fontWeight = 'bold';

hf = gcf;
ha = gca;

set(hf,'color','white');
set(ha,'fontsize',fontSize,'FontName',fontName,'FontWeight',fontWeight);
set(ha,'linewidth',lineWidth);

set(get(ha,'Xlabel'),'Fontsize',fontSize,'FontName',fontName,'FontWeight',fontWeight);
set(get(ha,'Ylabel'),'Fontsize',fontSize,'FontName',fontName,'FontWeight',fontWeight);
set(get(ha,'Title'),'Fontsize',fontSize,'FontName',fontName,'FontWeight',fontWeight);
title('');
if nargin >= 3
    thealphas = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n',...
        'o','p','q','r','s','t','u','v','w','x','y','z'};
    if isnumeric(addText)
        thestring = thealphas{addText};
    else
        thestring = addText{:};
    end
    text(-diff(xlim)/4,max(ylim)+diff(ylim)/8,...
            {['\fontname{courier}(' thestring ')']}, ...
            'fontsize',fontSize);
end
