%{

Script: Adaline.m
Version of the MATLAB implemented: 2017a.

Author: Nadia Matos
email: nadiamatos.18@gmail.com

This script is of Adaline RNA, doing learning and operation process.

%}
classdef Adaline < handle

  properties

    errorMeanSquareCurrent = 0; errorMeanSquareLast = 0;
    quantitySampleTraining = 90; % in percentage
    quantityOutputRna = 1; quantityInputRna = 0;
    inputRna = []; outputRnaDesired = []; quantitySample = 0;
    weigthRna = []; rateLearning = 0.05; epsilon = 10e-10; epoch = 0;
    
  end

  methods

    function obj = Adaline(database, percentageForTraining, quantInputs)

      obj.inputRna = [-1*ones(size(database, 1), 1), table2array(database(:, 1:quantInputs))];
      obj.outputRnaDesired = table2array(database(:, end));
      obj.quantityInputRna = size(obj.inputRna, 2);
      obj.quantitySample = size(database, 1);
      obj.quantitySampleTraining = floor(size(database, 1)*percentageForTraining/100);
      obj.weigthRna = rand(1, obj.quantityInputRna, 1); % vector with n rows;
      % obj.inputRna = obj.normalization(obj.inputRna);

    end

    function data = normalization(obj, data, c)

      for i = 2 : 1 : size(data, 2)
      
        data(:, i) = (data(:, i) - min(obj.inputRna(:, i)))./(max(obj.inputRna(:, i)) - min(obj.inputRna(:, i)));

      end

    end

    function u = neuron(obj, index, input)

      % parameter of the activation function

      if (isempty(input)); input = obj.inputRna(index, :); end
      
      u = input*obj.weigthRna';

      %if (u >= 0) y = 1; else y = -1; end

    end

    function erro = meanSquareError(obj)

      erro = 0;

      for k = 1 : 1 : obj.quantitySampleTraining
      
        erro = erro + (obj.outputRnaDesired(k) - obj.neuron(k, []))^2;

      end

      erro = erro/obj.quantitySampleTraining;

    end

    function training(obj)

      difference = inf; obj.errorMeanSquareLast = 0;

      while (difference >= obj.epsilon)
        
        disp('Training ...');
        obj.errorMeanSquareLast = obj.meanSquareError();
        
        for k = 1 : 1 : obj.quantitySampleTraining
        
          obj.weigthRna = obj.weigthRna + obj.rateLearning*(obj.outputRnaDesired(k) - obj.neuron(k, []))*obj.inputRna(k, :);

        end
        
        obj.epoch = obj.epoch + 1;
        obj.errorMeanSquareCurrent = obj.meanSquareError();
        difference = abs(obj.errorMeanSquareCurrent - obj.errorMeanSquareLast);

      end

    end

    function operation(obj)

      disp('Working ...');

      while true
    
        x = [-1 str2num(input('\nDigite amostra para teste na RNA Adaline: ', 's'))];
        %x = obj.normalization(x')';
        u = obj.neuron(0, x);
    
        if (u >= 0) y = 1; else y = -1; end
    
        if (y == 1)
    
          disp('Classe A, saida 1'); % correspondente a saida 1

        else
          
          disp('Classe B, saida -1'); % correspondente a saida -1

        end
    
      end

    end

  end

end
