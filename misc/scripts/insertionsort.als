(Algorit (main)
 ((for main ((var "data") (var "i") (var "insert") (var "j") (var "select") (var "sorted") (list "a"))
   (
   (sub insert
    ((setVar:to: "select" (plus:and: (getVar "sorted") 1))
     (setVar:to: "data" (getLine:ofList: (getVar "select") "a"))
     (setVar:to: "i" "1")
     (doUntil (more:than: (getVar "i") (getVar "sorted"))
      ((doIf (more:than: (getLine:ofList: (getVar "i") "a") (getVar "data"))
        ((setVar:to: "insert" (getVar "i"))
         (setVar:to: "j" (minus:with: (getVar "select") 1))
         (doRepeat (minus:with: (getVar "select") (getVar "insert"))
          ((setLine:ofList:to: (plus:and: (getVar "j") 1) "a" (getLine:ofList: (getVar "j") "a"))
           (changeVar:by: "j" -1)))
         (setLine:ofList:to: (getVar "insert") "a" (getVar "data"))
         (doReturn)))
       (changeVar:by: "i" 1)))))
   (when setup
    ((clearList: "a")
     (appendRandom:from:to:toList: 10 10 99 "a")))
   (when start
    ((setVar:to: "sorted" "1")
     (doRepeat (minus:with: (lineCountOfList: "a") 1)
      ((callSubroutine "insert")
       (changeVar:by: "sorted" 1)))))))))