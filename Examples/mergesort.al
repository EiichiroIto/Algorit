AlgoritV01   {'thumbnail':nil}AlgoritProject{#scripts:[AlgoritScript{#blocksBin:[[Point[20.0,158.0],[[#EventHatMorph,'start'],[#'clearList:','from'],[#'clearList:','to'],[#'clearList:','b'],[#'append:toList:',1,'from'],[#'append:toList:',[#'lineCountOfList:','a'],'to'],[#'append:toList:',1,'b'],[#doUntil,[#'=',[#'lineCountOfList:','b'],'0'],[[#callSubroutine,'divide']]],[#doUntil,[#'=',[#'lineCountOfList:','from'],'0'],[[#callSubroutine,'merge']]]]],[Point[20.0,20.0],[[#EventHatMorph,'setup'],[#'clearList:','a'],[#'appendRandom:from:to:toList:',90,10,99,'a']]],[Point[20.0,595.0],[[#SubHatMorph,'divide'],[#changeVariable,'left1',#'setVar:to:',[#'getLine:ofList:',[#'getLine:ofList:',1,'b'],'from']],[#changeVariable,'right2',#'setVar:to:',[#'getLine:ofList:',[#'getLine:ofList:',1,'b'],'to']],[#'deleteLine:ofList:',1,'b'],[#doIf,[#'<',[#readVariable,'left1'],[#readVariable,'right2']],[[#changeVariable,'left2',#'setVar:to:',[#'truncated:',[#/,[#'+',[#readVariable,'left1'],[#readVariable,'right2']],2]]],[#changeVariable,'right1',#'setVar:to:',[#'+',[#readVariable,'left2'],1]],[#doIf,[#'<',[#readVariable,'left1'],[#readVariable,'left2']],[[#'append:toList:',[#readVariable,'left1'],'from'],[#'append:toList:',[#readVariable,'left2'],'to'],[#'append:toList:',[#'lineCountOfList:','from'],'b']]],[#doIf,[#'<',[#readVariable,'right1'],[#readVariable,'right2']],[[#'append:toList:',[#readVariable,'right1'],'from'],[#'append:toList:',[#readVariable,'right2'],'to'],[#'append:toList:',[#'lineCountOfList:','from'],'b']]]]]]],[Point[411.0,17.0],[[#SubHatMorph,'merge'],[#'clearList:','b'],[#changeVariable,'left1',#'setVar:to:',[#'getLine:ofList:',-1,'from']],[#changeVariable,'right2',#'setVar:to:',[#'getLine:ofList:',-1,'to']],[#'deleteLine:ofList:',-1,'from'],[#'deleteLine:ofList:',-1,'to'],[#changeVariable,'left2',#'setVar:to:',[#'truncated:',[#/,[#'+',[#readVariable,'left1'],[#readVariable,'right2']],2]]],[#changeVariable,'right1',#'setVar:to:',[#'+',[#readVariable,'left2'],1]],[#changeVariable,'x',#'setVar:to:',[#readVariable,'left1']],[#doUntil,[#'|',[#'>',[#readVariable,'left1'],[#readVariable,'left2']],[#'>',[#readVariable,'right1'],[#readVariable,'right2']]],[[#doIfElse,[#'<',[#'getLine:ofList:',[#readVariable,'left1'],'a'],[#'getLine:ofList:',[#readVariable,'right1'],'a']],[[#'append:toList:',[#'getLine:ofList:',[#readVariable,'left1'],'a'],'b'],[#changeVariable,'left1',#'changeVar:by:',1]],[[#'append:toList:',[#'getLine:ofList:',[#readVariable,'right1'],'a'],'b'],[#changeVariable,'right1',#'changeVar:by:',1]]]]],[#doUntil,[#'>',[#readVariable,'left1'],[#readVariable,'left2']],[[#'append:toList:',[#'getLine:ofList:',[#readVariable,'left1'],'a'],'b'],[#changeVariable,'left1',#'changeVar:by:',1]]],[#doUntil,[#'>',[#readVariable,'right1'],[#readVariable,'right2']],[[#'append:toList:',[#'getLine:ofList:',[#readVariable,'right1'],'a'],'b'],[#changeVariable,'right1',#'changeVar:by:',1]]],[#changeVariable,'y',#'setVar:to:','1'],[#doUntil,[#'>',[#readVariable,'x'],[#readVariable,'right2']],[[#'setLine:ofList:to:',[#readVariable,'x'],'a',[#'getLine:ofList:',[#readVariable,'y'],'b']],[#changeVariable,'x',#'changeVar:by:',1],[#changeVariable,'y',#'changeVar:by:',1]]]]]],#project:@1,#objName:'main',#varNames:OrderedCollection['left1','left2','right1','right2','x','y'],#listVarNames:OrderedCollection['a','b','from','to'],#evaluator:AlgoritEvaluator{#watchingVars:Set['left2','y','right1','left1','x','right2'],#lists:{#rest:OrderedCollection[],#to:OrderedCollection[],#from:OrderedCollection[],#a:OrderedCollection[39,44,90,89,59,33,97,42,25,40,15,48,16,72,94,83,28,68,19,34,46,62,54,66,67,64,91,24,96,29,51,35,14,77,13,69,17,47,41,58,21,61,22,49,30,76,57,31,73,92,55,10,23,11,60,27,81,75,85,65,37,53,43,79,18,78,86,50,82,63,38,87,98,93,88,84,12,26,45,36,52,74,20,80,99,32,56,95,71,70],#b:OrderedCollection[]},#vars:{#left2:50,#y:101,#right1:101,#left1:51,#x:101,#right2:100},#varHistory:OrderedCollection[],#messages:''}}],#info:{'thumbnail':nil}}