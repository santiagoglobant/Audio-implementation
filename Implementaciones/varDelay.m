classdef varDelay<handle
    properties
        M
        maxDelay
        buffer
        pW
        pR
    end
    methods
        function obj=varDelay(M)
            obj.maxDelay=44100;
            if M>obj.maxDelay   %Restriccion de delay maximo
                obj.M=obj.maxDelay;
            else
                obj.M=M;
            end
            obj.buffer=zeros(1,obj.maxDelay);
            obj.pW=obj.maxDelay;
            obj.pR=obj.pW-obj.M;
        end
        function setDelay(obj,M)
            if M>obj.maxDelay   %Restriccion de delay maximo
                obj.M=obj.maxDelay;
            else
                obj.M=M;
            end
            obj.pR=obj.pW-obj.M;
        end
        function out=process(obj,x)           
            obj.buffer(mod(obj.pW,obj.maxDelay)+1)=x;
            out=obj.buffer(mod(obj.pR,obj.maxDelay)+1);                     
            obj.pW=obj.pW+1;
            obj.pR=obj.pR+1;
        end
    end
end