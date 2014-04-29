__author__ = 'adeb'


import layer


class Network():
    def __init__(self, n_in, n_out, x):
        print '... initialize the model'
        self.n_in = n_in
        self.n_out = n_out
        self.x = x


class Network1(Network):
    def __init__(self, n_in, n_out, x):
        Network.__init__(self, n_in, n_out, x)

        self.layers = [layer.LayerTan(n_in, 500, x)]
        self.layers.append(layer.LayerSoftMax(500, n_out, self.layers[-1].y))

        self.y = self.layers[-1].y

        self.params = []
        for l in self.layers:
            self.params += l.params

    def cost(self, y_true):
        return self.layers[-1].mse(y_true)

    def errors(self, y_true):
        return self.layers[-1].errors(y_true)