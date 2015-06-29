function wait_pause(str,Steps,Period)
eval(strcat('h=waitbar(0,''',str,'.  Please wait..''',')'))  
    for cc=1:Steps
       waitbar(cc/Steps)
       pause(Period)
    end
    close(h)  