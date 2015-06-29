 
function speaker_TACWrapper(txt)
%DO NOT EDIT_________________________________________________________________ 
% This file is located in TACTICS open code library.
% All rights reserved to its original authors.
% Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
% Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer 
% in the documentation and/or other materials provided with the distribution.  
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
% THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
% OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
% THE POSSIBILITY OF SUCH DAMAGE. 
% Important: This file may include some code editing to enable incorporation with TACTICS Toolbox
% ___________________________________________________________________________ 
% Modified from tts.m  by Siyi Deng; 12-21-2007;

 if ~ispc, error('Microsoft Win32 SAPI is required.'); end
 if ~ischar(txt), error('First input must be string.'); end

SV = actxserver('SAPI.SpVoice');
TK = invoke(SV,'GetVoices');
%  SV.Voice = TK.Item(1) 
%  SV.Rate =  3;
 fs = 48000;  
   % Output variable;
   MS = actxserver('SAPI.SpMemoryStream') 
   MS.Format.Type = sprintf('SAFT%dkHz16BitStereo',fix(fs/1000)) 
   SV.AudioOutputStream = MS  
 

invoke(SV,'Speak',txt); 
 
    wav = reshape(double(invoke(MS,'GetData')),2,[])';
    wav = (wav(:,2)*256+wav(:,1))/32768;
    wav(wav >= 1) = wav(wav >= 1)-2;
    sound(wav,80000);
    
     delete(MS);
      clear MS;
 

  delete(SV); 
  clear SV TK;
pause(0.2);
