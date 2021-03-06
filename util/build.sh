#!/bin/bash
cd ${0%/*}
echo "[Combining modules...]"
cat ../src/util/EventDispatcher.ts ../src/Listener.ts ../src/interfaces/DefaultListener.ts ../src/util/LeapEvent.ts ../src/util/LeapUtil.ts ../src/Controller.ts ../src/InteractionBox.ts ../src/Pointable.ts ../src/Gesture.ts ../src/Finger.ts ../src/Tool.ts ../src/Hand.ts ../src/Frame.ts ../src/Matrix.ts ../src/CircleGesture.ts ../src/KeyTapGesture.ts ../src/ScreenTapGesture.ts ../src/SwipeGesture.ts ../src/Vector3.ts | sed 's/\/\/\/.*$//' > ../build/cat.ts

echo "[Making module/interface/enum external...]"
sed 's/class /export class /' ../build/cat.ts | sed 's/interface /export interface /' | sed 's/enum /export enum /' > ../build/leapmotionts-1.0.8.ts

echo "[Running TypeScript compiler...]"
tsc --declaration --module amd --target ES5 ../build/leapmotionts-1.0.8.ts

echo "[Running Closure Compiler...]"
java \
-jar ./build/compiler.jar \
--js_output_file ../build/leapmotionts-1.0.8.min.js \
--js ../build/leapmotionts-1.0.8.js

echo "[Clean up...]"
rm -Rf ../build/cat.ts

echo "[Done!]"
