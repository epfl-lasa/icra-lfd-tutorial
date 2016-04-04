function data = get_demonstration(fig)
% to store the data
X = [];
% flag for signaling that the demonstration has ended
finished = 0;

% select our figure as gcf
figure(fig);
hold on
% disable any figure modes
zoom off 
rotate3d off
pan off
brush off  
datacursormode off 

set(fig,'WindowButtonDownFcn',@(h,e)button_clicked(h,e));
set(fig,'WindowButtonUpFcn',[]);
set(fig,'WindowButtonMotionFcn',[]);

% wait until demonstration is finished
while(~finished)
    pause(0.1);
end
% set the return value
data = X;
return

    function ret = button_clicked(h,e)
        if(strcmp(get(gcf,'SelectionType'),'normal'))
            start_demonstration();
        end
    end

    function ret = start_demonstration()
        disp('started demonstration')
        set(gcf,'WindowButtonUpFcn',@stop_demonstration);
        set(gcf,'WindowButtonMotionFcn',@record_current_point);
        ret = 1;
        tic;
    end

    function ret = stop_demonstration(h,e)
        disp('stopped demonstration')
        set(gcf,'WindowButtonMotionFcn',[]);
        set(gcf,'WindowButtonUpFcn',[]);
        set(gcf,'WindowButtonDownFcn',[]);
        finished = 1;
    end

    function ret = record_current_point(h,e)
        x = get(gca,'Currentpoint');
        x = x(1,1:2)';
        x = [x;toc];
        X = [X, x];
        plot(x(1),x(2),'r.')
    end
end
