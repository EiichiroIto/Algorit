AlgoritV01   {'thumbnail':nil}AlgoritProject{#scripts:[AlgoritScript{#blocksBin:[[Point[20.0,20.0],[[#EventHatMorph,'setup'],[#'clearList:','a'],[#'appendRandom:from:to:toList:',20,10,99,'a']]],[Point[20.0,145.0],[[#EventHatMorph,'start'],[#changeVariable,'sorted',#'setVar:to:','1'],[#doRepeat,[#-,[#'lineCountOfList:','a'],1],[[#callSubroutine,'insert'],[#changeVariable,'sorted',#'changeVar:by:',1]]]]],[Point[20.0,353.0],[[#SubHatMorph,'insert'],[#changeVariable,'select',#'setVar:to:',[#'+',[#readVariable,'sorted'],1]],[#changeVariable,'data',#'setVar:to:',[#'getLine:ofList:',[#readVariable,'select'],'a']],[#changeVariable,'i',#'setVar:to:','1'],[#doUntil,[#'>',[#readVariable,'i'],[#readVariable,'sorted']],[[#doIf,[#'>',[#'getLine:ofList:',[#readVariable,'i'],'a'],[#readVariable,'data']],[[#changeVariable,'insert',#'setVar:to:',[#readVariable,'i']],[#changeVariable,'j',#'setVar:to:',[#-,[#readVariable,'select'],1]],[#doRepeat,[#-,[#readVariable,'select'],[#readVariable,'insert']],[[#'setLine:ofList:to:',[#'+',[#readVariable,'j'],1],'a',[#'getLine:ofList:',[#readVariable,'j'],'a']],[#changeVariable,'j',#'changeVar:by:',-1]]],[#'setLine:ofList:to:',[#readVariable,'insert'],'a',[#readVariable,'data']],[#doReturn]]],[#changeVariable,'i',#'changeVar:by:',1]]]]]],#project:@1,#objName:'main',#varNames:OrderedCollection['select','sorted','i','data','insert','j'],#listVarNames:OrderedCollection['a'],#evaluator:AlgoritEvaluator{#watchingVars:Set['i','sorted','insert','j','select','data'],#lists:{#a:OrderedCollection[58,66,17,99,64,91,69,29,96,86,93,34,62,10,70,72,89,94,48,41]},#vars:{#i:20,#sorted:20,#insert:2,#j:1,#select:20,#data:99},#varHistory:OrderedCollection[],#messages:''}}],#info:{'thumbnail':nil}}