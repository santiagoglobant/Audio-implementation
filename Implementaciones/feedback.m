classdef feedback<handle
    properties
        M
        maxDelay
        gain
        buffer
        pW
        pR
    end
    methods
        function obj=feedback(M,gain)
            obj.maxDelay=44100;
            if M>obj.maxDelay   %Restriccion de delay maximo
                obj.M=obj.maxDelay;
            else
                obj.M=M;
            end
            obj.gain=gain;
            obj.buffer=zeros(1,obj.maxDelay);
            obj.pW=obj.maxDelay;
            obj.pR=obj.pW-obj.M;
        end
        function out=process(obj,in)
            out=in + obj.gain*obj.buffer(mod(obj.pR,obj.maxDelay)+1);
            obj.buffer(mod(obj.pW,obj.maxDelay)+1)=out;                    
            obj.pW=obj.pW+1;
            obj.pR=obj.pR+1;
        end
    end
end