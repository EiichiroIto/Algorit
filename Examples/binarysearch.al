AlgoritV01   ){#author:'','comment':'','thumbnail':nil}AlgoritProject{#scripts:[AlgoritScript{#blocksBin:[[Point[20.0,176.0],[[#EventHatMorph,'start'],[#changeVariable,'x',#'setVar:to:','92'],[#changeVariable,'s',#'setVar:to:','1'],[#changeVariable,'e',#'setVar:to:',[#'lineCountOfList:','a']],[#doUntil,[#'more:than:',[#readVariable,'s'],[#readVariable,'e']],[[#changeVariable,'i',#'setVar:to:',[#'rounded:',[#'divide:by:',[#'plus:and:',[#readVariable,'s'],[#readVariable,'e']],2]]],[#doIf,[#'equal:to:',[#readVariable,'x'],[#'getLine:ofList:',[#readVariable,'i'],'a']],[[#'print:',[#readVariable,'x']],[#'print:',' found at '],[#'println:',[#readVariable,'i']],[#stopAll]]],[#doIfElse,[#'less:than:',[#readVariable,'x'],[#'getLine:ofList:',[#readVariable,'i'],'a']],[[#changeVariable,'e',#'setVar:to:',[#'minus:with:',[#readVariable,'i'],1]]],[[#changeVariable,'s',#'setVar:to:',[#'plus:and:',[#readVariable,'i'],1]]]]]],[#'print:',[#readVariable,'x']],[#'println:',' is not found.']]],[Point[20.0,20.0],[[#EventHatMorph,'setup'],[#'clearList:','a'],[#'appendRandom:from:to:toList:',20,10,99,'a'],[#'sortList:','a']]]],#project:@1,#objName:'main',#varNames:OrderedCollection['x','s','e','i','y'],#listVarNames:OrderedCollection['a'],#evaluator:AlgoritEvaluator{#vars:{#i:17,#e:17,#y:94,#s:17,#x:'92'},#lists:{#a:OrderedCollection[12,20,26,29,31,34,42,47,54,57,59,64,69,80,83,87,92,95,97,98]},#watchingVars:Set['i','e','y','s','x'],#varHistory:OrderedCollection[],#messages:'',#timer:Timespan{#start:DateAndTime['2023-02-15T15:02:45.015093+09:00'],#duration:Duration{#nanos:0,#seconds:0}}}}],#info:{#author:'','comment':'','thumbnail':nil}}