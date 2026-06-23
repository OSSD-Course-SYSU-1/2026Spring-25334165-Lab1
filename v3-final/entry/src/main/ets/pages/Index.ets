/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Constants from '../constants/Constants';
import TextGradientView from '../view/TextGradientView';
import TextMarqueeView from '../view/TextMarqueeView';
import TextReflectionView from '../view/TextReflectionView';
import TextScrollingView from '../view/TextScrollingView';
import { promptAction } from '@kit.ArkUI';

@Observed
export class arrText {
  effect: string;
  content: ResourceStr;
  color: Color;

  constructor(effect: string, content: ResourceStr, color: Color) {
    this.effect = effect;
    this.content = content;
    this.color = color;
  }
}
@Entry
@Component
struct Index {
  @State message: ResourceStr = $r('app.string.text_content');
  @State messageLong: ResourceStr = $r('app.string.text_content_long');
  @State value: number = 0;
  @State arrText: arrText[] = [];
  @State TextReflectionViewColor: Color = Color.Red;
  @State TextMarqueeViewColor: Color = Color.Black;
  @State TextScrollingViewColor: Color = Color.Red;
  pageStack: NavPathStack = new NavPathStack();
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: () => {
        this.onCancel();
      },
      confirm: (text: string, text1: string, color: Color) => {
        this.onAccept(text, text1, color);
      }
    }),
    alignment: DialogAlignment.Center,
    width: '100%',
    height: 400,
  })

  onCancel() {
    console.info('Callback when the first button is clicked');
  }

  onAccept(text: string, text1: string, color: Color) {
    this.arrText.push(new arrText(text, text1, color))
  }

  @Styles
  fancy() {
    .borderRadius($r('app.float.row_border_radius'))
    .backgroundColor(Color.White)
    .padding({
      top: $r('app.float.row_padding'),
      bottom: $r('app.float.row_padding')
    })
    .width(Constants.FULL_PERCENT)
  }

  @Builder
  textBuilder(value: ResourceStr | string, isWide: boolean = false) {
    Row() {
      Text(value)
        .fontSize($r("app.float.title_font_size"))
        .fontColor($r('app.color.title_font_color'))
        .fontWeight(Constants.FONT_WEIGHT_500)
        .margin({ top: $r('app.float.title_margin_bottom') })
        .lineHeight($r('app.float.title_line_height'))
    }
    .width(isWide ? Constants.FULL_PERCENT : '70%')
    .height($r('app.float.title_row_height'))
    .margin({ bottom: $r('app.float.title_row_margin_bottom') })
  }
  @Builder
  itemEnd(index: number) {
    Row() {
      Text('删除')
        .margin({ left: 8, top: 10 })
        .fontSize(16)
        .backgroundColor('#808080')
        .fontColor(Color.White)
        .borderRadius(16)
        .textAlign(TextAlign.Center)
        .width(100)
        .height(100.5)
        .onClick(() => {
          this.arrText.splice(index, 1);
        });
    }.padding(4).justifyContent(FlexAlign.SpaceEvenly);
  }
  build() {
    Navigation(this.pageStack) {
      Scroll() {
        Column() {
          this.textBuilder($r('app.string.text_gradient'), true)
          Row() {
            TextGradientView({ message: this.message })
          }
          .fancy()
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            let Grad: arrText = new arrText('文字渐变效果', this.message,Color.Transparent)
            this.pageStack.pushPath({ name: "FullScreen", param: Grad })
          })

          Row() {
            this.textBuilder($r('app.string.text_scrolling'), false)
            Select([{ value: '红色' },
              { value: '黄色' },
              { value: '蓝色' },
              { value: '粉色' },
              { value: '绿色' },
            ])
              .value('选择')
              .onSelect((index: number, color: string) => {
                switch (color) {
                  case '红色':
                    this.TextScrollingViewColor = Color.Red;
                    break;
                  case '黄色':
                    this.TextScrollingViewColor = Color.Yellow;
                    break;
                  case '蓝色':
                    this.TextScrollingViewColor = Color.Blue;
                    break;
                  case '粉色':
                    this.TextScrollingViewColor = Color.Pink;
                    break;
                  case '绿色':
                    this.TextScrollingViewColor = Color.Green;
                    break;
                }
              })
              .borderRadius(3)
          }

          Row() {
            TextScrollingView({ message: this.message, TextScrollingViewColor: this.TextScrollingViewColor })
          }
          .fancy()
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            let Scrolling: arrText = new arrText('歌词滚动效果', this.message, this.TextScrollingViewColor)
            this.pageStack.pushPath({ name: "FullScreen", param:Scrolling })
          })

          Row() {
            this.textBuilder($r('app.string.text_reflection'), false)
            Select([{ value: '红色' },
              { value: '黄色' },
              { value: '蓝色' },
              { value: '粉色' },
              { value: '绿色' },
            ])
              .value('选择')
              .onSelect((index: number, color: string) => {
                switch (color) {
                  case '红色':
                    this.TextReflectionViewColor = Color.Red;
                    break;
                  case '黄色':
                    this.TextReflectionViewColor = Color.Yellow;
                    break;
                  case '蓝色':
                    this.TextReflectionViewColor = Color.Blue;
                    break;
                  case '粉色':
                    this.TextReflectionViewColor = Color.Pink;
                    break;
                  case '绿色':
                    this.TextReflectionViewColor = Color.Green;
                    break;
                }
              })
              .borderRadius(3)
          }

          Row() {
            TextReflectionView({ message: this.message, TextReflectionViewColor: this.TextReflectionViewColor })
          }
          .fancy()
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            let Reflection: arrText = new arrText('文字倒影效果', this.message, this.TextReflectionViewColor)
            this.pageStack.pushPath({ name: "FullScreen", param:Reflection })
          })

          Row() {
            this.textBuilder($r('app.string.text_marquee'), false)
            Select([{ value: '红色' },
              { value: '黄色' },
              { value: '蓝色' },
              { value: '粉色' },
              { value: '绿色' },
            ])
              .value('选择')
              .onSelect((index: number, color: string) => {
                switch (color) {
                  case '红色':
                    this.TextMarqueeViewColor = Color.Red;
                    break;
                  case '黄色':
                    this.TextMarqueeViewColor = Color.Yellow;
                    break;
                  case '蓝色':
                    this.TextMarqueeViewColor = Color.Blue;
                    break;
                  case '粉色':
                    this.TextMarqueeViewColor = Color.Pink;
                    break;
                  case '绿色':
                    this.TextMarqueeViewColor = Color.Green;
                    break;
                }
              })
              .borderRadius(3)
          }

          Row() {
            TextMarqueeView({ message: this.messageLong, TextMarqueeViewColor: this.TextMarqueeViewColor })
          }
          .fancy()
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            let Marquee: arrText = new arrText('跑马灯渐变效果', this.messageLong, this.TextMarqueeViewColor)
            this.pageStack.pushPath({ name: "FullScreen", param:Marquee })
          })


          Button('新增')
            .width('90%')
            .height(40)
            .borderRadius(3)
            .type(ButtonType.Normal)
            .margin({
              top: 30
            })
            .onClick(() => {
              if (this.dialogController != null) {
                this.dialogController.open();
              }
            })
          List({ space: 20 }) {
            ForEach(this.arrText, (item: arrText,index:number) => {
              ListItem() {
                Column() {
                  Row() {
                    this.textBuilder(item.effect, item.effect === '文字渐变效果')
                    if (item.effect != '文字渐变效果') {
                      Select([{ value: '红色' },
                        { value: '黄色' },
                        { value: '蓝色' },
                        { value: '粉色' },
                        { value: '绿色' }])
                        .value('选择')
                        .onSelect((index: number, color: string) => {
                          switch (color) {
                            case '红色':
                              item.color = Color.Red;
                              break;
                            case '黄色':
                              item.color = Color.Yellow;
                              break;
                            case '蓝色':
                              item.color = Color.Blue;
                              break;
                            case '粉色':
                              item.color = Color.Pink;
                              break;
                            case '绿色':
                              item.color = Color.Green;
                              break;
                          }
                        })
                        .borderRadius(3)
                    }
                  }

                  Row() {
                    if (item.effect === '文字渐变效果') {
                      TextGradientViewIndex({ message: item.content })
                    } else if (item.effect === '歌词滚动效果') {
                      TextScrollingViewIndex({ TextScrollingViewIndex: item })
                    } else if (item.effect === '文字倒影效果') {
                      TextRefectionViewIndex({ TextRefectionViewIndex: item })
                    } else if (item.effect === '跑马灯渐变效果') {
                      TextMarqueeViewIndex({ TextMarqueeViewIndex: item })
                    }
                  }
                  .fancy()
                  .justifyContent(FlexAlign.Center)
                }

              }
              .swipeAction({ end: this.itemEnd.bind(this, index), edgeEffect: SwipeEdgeEffect.Spring })
              .onClick(() => {
                this.pageStack.pushPath({ name: "FullScreen", param: item })
              })
            })
          }
          .margin({
            top: 20
          })
        }
        .padding({
          left: $r('app.float.area_padding_left'),
          right: $r('app.float.area_padding_left')
        })
      }

    }
    .height(Constants.FULL_PERCENT)
    .width(Constants.FULL_PERCENT)
    .title($r('app.string.title'))
    .backgroundColor($r('app.color.page_background_color'))
    .mode(NavigationMode.Stack)
  }
}

@CustomDialog
struct CustomDialogExample {
  controller?: CustomDialogController;
  cancel: () => void = () => {
  }
  confirm: (text: string, text1: string, color: Color) => void = () => {
  }
  @State text: string = '';
  @State text1: string = '';
  @State selectedColor: Color = Color.Transparent;

  build() {
    Column({ space: 10 }) {
      Row() {
        Text(this.text)
          .width('70%')
        Select([{ value: $r('app.string.text_gradient') },
          { value: $r('app.string.text_scrolling') },
          { value: $r('app.string.text_reflection') },
          { value: $r('app.string.text_marquee') }])
          .value('选择一个效果')
          .onSelect((index: number, text: string) => {
            console.info('Select:' + index);
            this.text = text;
          })
          .borderRadius(3)
          .width('30%')
      }
      .backgroundColor('#c5c5c5')
      .width('100%')

      TextInput({ placeholder: '请输入内容,不超过12个字' })
        .maxLength(12)
        .onChange((text: string) => {
          this.text1 = text;
        })
        .borderRadius(3)

      Row() {
        Button('关闭')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close();
              this.cancel();
              this.text = '';
              this.text1 = '';
            }
          })
        Button('确认')
          .onClick(() => {
            if (this.controller != undefined) {
              if (this.text === '' || this.text1 === '') {
                promptAction.openToast({message: '不可为空'})
              }else {
                this.controller.close();
                this.confirm(this.text, this.text1, this.selectedColor);
              }

            }
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')

      .margin(20)
    }
    .margin(40)
  }
}

@Component
export default struct TextGradientViewIndex {
  @State message: ResourceStr = '';

  build() {
    Row() {
      Text(this.message)
        .fontSize($r('app.float.content_font_size'))
        .fontWeight(FontWeight.Bold)
        .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
    }
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [[$r('app.color.gradient_start_color'), 0.0], [$r('app.color.gradient_end_color'), 1]]
    })
    .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
  }
}


@Component
export struct TextScrollingViewIndex {
  @State value: number = 0;
  @ObjectLink TextScrollingViewIndex: arrText;

  build() {
    Row() {
      Text(this.TextScrollingViewIndex.content)
        .fontSize($r('app.float.content_font_size'))
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
    }
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [[this.TextScrollingViewIndex.color === Color.Transparent ? Color.Red : this.TextScrollingViewIndex.color,
        0.0], [this.TextScrollingViewIndex.color === Color.Transparent ? Color.Red : this.TextScrollingViewIndex.color,
        this.value], [Color.Black, this.value], [Color.Black, 1.0]]
    })
    .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
    .backgroundImageSize({
      width: 0,
      height: 0
    })
    .onAppear(() => {
      this.getUIContext().animateTo({
        duration: Constants.TEXT_SCROLL_DURATION,
        finishCallbackType: FinishCallbackType.LOGICALLY,
        curve: Curve.Linear,
        iterations: -1,
        onFinish: () => {
          this.value = 0
        }
      }, () => {
        this.value = 1
      });
    })
  }
}

@Component
export struct TextRefectionViewIndex {
  @ObjectLink TextRefectionViewIndex: arrText;

  build() {
    Stack() {
      Text(this.TextRefectionViewIndex.content)
        .fontSize($r('app.float.content_font_size'))
        .fontColor(this.TextRefectionViewIndex.color === Color.Transparent ? Color.Red :
          this.TextRefectionViewIndex.color)
        .fontWeight(FontWeight.Bold)
      Text(this.TextRefectionViewIndex.content)
        .fontSize($r('app.float.content_font_size'))
        .fontColor(this.TextRefectionViewIndex.color === Color.Transparent ? Color.Red :
          this.TextRefectionViewIndex.color)
        .fontWeight(FontWeight.Bold)
        .rotate({
          x: 1,
          y: 0,
          z: 0,
          angle: Constants.ANGLE_DEGREE,
          centerX: Constants.FIFTY_PERCENT,
          centerY: Constants.FULL_PERCENT
        })
        .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
    }
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[Color.Transparent, 0], [Color.Transparent, 0.50],
        [this.TextRefectionViewIndex.color === Color.Transparent ? Color.Red : this.TextRefectionViewIndex.color, 0.50],
        [$r('app.color.text_reflection_color'), 1]]
    })
    .height($r('app.float.text_refection_height'))
    .alignContent(Alignment.Top)
    .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
  }
}

@Component
export struct TextMarqueeViewIndex {
  @ObjectLink TextMarqueeViewIndex: arrText;

  build() {
    Row() {
      Column() {
        Text(this.TextMarqueeViewIndex.content)
          .width($r('app.string.ninety_percent'))
          .fontColor(this.TextMarqueeViewIndex.color === Color.Transparent ? Color.Black :
            this.TextMarqueeViewIndex.color)
          .fontSize($r('app.float.content_font_size'))
          .fontWeight(FontWeight.Bold)
          .textOverflow({ overflow: TextOverflow.MARQUEE })
      }
      .blendMode(BlendMode.SRC_IN, BlendApplyType.OFFSCREEN)
      .backgroundColor(Color.Transparent)
      .width(Constants.FULL_PERCENT)
    }
    .width(Constants.FULL_PERCENT)
    .linearGradient({
      angle: Constants.ANGLE_DEGREE_HORIZONTAL,
      colors: [[Color.Transparent, 0], [Color.Black, 0.2],
        [this.TextMarqueeViewIndex.color === Color.Transparent ? Color.Black : this.TextMarqueeViewIndex.color, 0.8],
        [Color.Transparent, 1]]
    })
    .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
  }
}