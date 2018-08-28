classdef implicitFilter < handle
    
    properties
        order_;
        rank_;
        widthA;
        widthT;
        height;
        alpha_f;
        T;
        A;
    end
    
    methods
    function obj=implicitFilter(order_, alpha10)
        obj.order_ = order_;
        obj.rank_ = floor(order_/2);
        obj.widthA = 11;
        obj.widthT = 3;
        obj.height = 11;
        obj.alpha_f = IF_tuningAlpha(alpha10,order_);
        obj.T = IF_makeT(obj.alpha_f, obj.height, obj.widthT, obj.rank_);
        obj.A = IF_makeA(obj.alpha_f, obj.height, obj.widthA, order_);
        disp('Implicit filter is created')
    end
    function f_tilda = filtering(obj, f)
        len = length(f);
        if(len>3)
            Af = IF_mult(obj.A,f);
            f_tilda = IF_TDMA(obj.T,Af);
        else
            f_tilda = f;
        end
    end

    end
    
end

