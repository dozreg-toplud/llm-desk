/*  weights-00  %octs  /weight-splits/weight-splits-00/octs
/*  weights-01  %octs  /weight-splits/weight-splits-01/octs
/*  weights-02  %octs  /weight-splits/weight-splits-02/octs
/*  weights-03  %octs  /weight-splits/weight-splits-03/octs
/*  weights-04  %octs  /weight-splits/weight-splits-04/octs
/*  weights-05  %octs  /weight-splits/weight-splits-05/octs
/*  weights-06  %octs  /weight-splits/weight-splits-06/octs
/*  weights-07  %octs  /weight-splits/weight-splits-07/octs
/*  weights-08  %octs  /weight-splits/weight-splits-08/octs
/*  weights-09  %octs  /weight-splits/weight-splits-09/octs
/*  weights-10  %octs  /weight-splits/weight-splits-10/octs
/*  weights-11  %octs  /weight-splits/weight-splits-11/octs
::
=/  splits=(list octs)
  :~
    weights-00
    weights-01
    weights-02
    weights-03
    weights-04
    weights-05
    weights-06
    weights-07
    weights-08
    weights-09
    weights-10
    weights-11
  ==
::
^-  octs
:-  (roll (turn splits head) add)
(can 3 splits)
