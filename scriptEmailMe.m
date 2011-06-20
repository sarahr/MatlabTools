%% Script to alert by email when there is an error or when something is done.

dbstop in scriptEmailMe at 23
try
    
    %------------------ WRITE YOUR FUNCTIONS BELOW ---------------------
    corrSubjDist;
  
    %-------------------------------------------------------------------

    %------------------- WRITE YOUR MESSAGE ABOVE ----------------------
    subject = {'sp04sp09sp14sp19.mat is done!'};
    message = {'Successful completion.'};
    %-------------------------------------------------------------------
   

    % If completed without error, send message
    send_text_message('abbiekressner','gmail',subject,message);
    
catch exception
   
    send_text_message('abbiekressner','gmail','MATLAB error.',getReport(exception));
    rethrow(exception);
    therewasanerror = true; % this is just a line to stop on for debug mode

end
