classdef shimhardware
    %SHIMHARDWARE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        s
    end
    
    methods
        function obj = shimhardware(serial_port_name)
            %SHIMHARDWARE Construct an instance of this class
            %   Detailed explanation goes here
            obj.s = serialport(serial_port_name,115200);
            obj.s.configureTerminator("CR/LF")
            obj.s.configureCallback("terminator",...
                   @obj.printSerialData);
        end
        
        function transfer_shim_currents(obj,channels,blocks,lengths,reps,e,currents)
            %transfer_shim_currents Summary of this method goes here
            %   Detailed explanation goes here
              obj.s.writeline(sprintf("%sc%d|b%d|l%sr%se%d|",...
                                    char(1),...
                                    channels,...
                                    blocks,...
                                    sprintf('%d|',lengths),...
                                    sprintf('%d|',reps),...
                                    e=='L'));
                                
              pause(0.001);
              obj.s.write(currents,'single');
%               pause(0.00);
                  
        end
        
        function zero(obj)
            obj.s.write('Z','string');
        end
        
        function advance(obj)
            obj.s.write('T','string');
        end
        
        function configure_to_start(obj)
            obj.s.write('M','string');
        end
        
        function display_currents(obj)
            obj.s.write('I','string');
        end
        
        function calibrate_currents(obj)
            obj.s.write('C','string');
        end
        
        function printSerialData(~,src,~)
            data = readline(src);
            fprintf("%s\n",data);
        end
        
       
    end
end




