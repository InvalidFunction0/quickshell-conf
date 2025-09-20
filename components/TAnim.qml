import QtQuick

SequentialAnimation {
  id: root

  property QtObject target
  property string fadeProperty: "opacity"
  property int fadeDuration: 300

  // I genuinely do not understand this but StackOverflow did so

  NumberAnimation {
    id: outAnimation
    target: root.target
    property: root.fadeProperty
    duration: root.fadeDuration
    to: 0
    easing.type: Easing.InOutQuad
  }

  PropertyAction {} // actually change the property targetted by Behavior between anims

  NumberAnimation {
    id: inAnimation
    target: root.target
    property: root.fadeProperty
    duration: root.fadeDuration
    to: 1
    easing.type: Easing.InOutQuad
  }
}

