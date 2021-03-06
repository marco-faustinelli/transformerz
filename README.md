# transformerz

![alt image](/img/transformers.png)

Monad transformers in Haskell from the ground up. Nothing imported, just code.

Current development is in directory haskell/nilsson. Tests are provided, using hunit.

The idea is to implement the algorithm described in [1] avoiding the official mtl stuff and using instead the Lego blocks described in [2].

Why's that? The `mtl` library features transformers which implement a lot of each other's interfaces. This allows to invoke operations with little care about which layer of the monad pile we're in.

I believe that, in order to understand this complicated matter, it's better to start by keeping the various layers clearly separated and use `lift` consciously whenever we need one or another operation.

[1] http://www.cs.virginia.edu/~wh5a/personal/Transformers.pdf

[2] http://www.cs.nott.ac.uk/~nhn/MGS2006/LectureNotes/lecture03-9up.pdf

[3] http://blog.sigfpe.com/2006/05/grok-haskell-monad-transformers.html
