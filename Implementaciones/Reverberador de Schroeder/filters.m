classdef filters<handle
    properties
        num
        den
        order
        gain
        type
        buffer
    end
    methods
        function obj=filters(m,g,t)
            obj.order=m;
            obj.gain=g;
            obj.type=t;
            obj.buffer=zeros(1,44100);
            switch t
              case 'Delay Line'
                  obj.num=[0 zeros(1,m-1) g];
                  obj.den=[1 zeros(1,m-1) 0];
              case 'Feedforward'
                  obj.num=[1 zeros(1,m-1) g];
                  obj.den=[1 zeros(1,m-1) 0];
              case 'Feedback'
                  obj.num=[1 zeros(1,m-1) 0];
                  obj.den=[1 zeros(1,m-1) -g];
              case 'All Pass'
                  obj.num=[-g zeros(1,m-1) 1];
                  obj.den=[1 zeros(1,m-1) -g];
            end
        end
        function out=process(obj,in)
            out=(obj.num(1)*in+obj.buffer(obj.order))/obj.den(1);
            obj.buffer=[obj.num(obj.order+1)*in-obj.den(obj.order+1)*out obj.buffer(1:obj.order-1)];
        end
    end
end