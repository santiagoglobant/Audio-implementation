function graphic_function(in,out,fs,gtitle)
    hold on
    grid on
    set(gcf,'Name',gtitle)
    set(gcf,'Position',[9, 49, 1351, 641])
    set(gcf,'Color',[1,1,1])
        t=0:1/fs:(length(in)-1)/fs;
        plot(t,in,'LineWidt',1,'Color','b')
        plot(t,out,'LineWidt',1,'Color','r')
    title(gtitle)
    xlabel('Time')
    ylabel('Amplitude')
    legend('In X','Out Y')
end