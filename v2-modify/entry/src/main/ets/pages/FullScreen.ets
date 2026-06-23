import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { arrText } from './Index';
import Constants from '../constants/Constants';

@Component
struct FullScreen {
  @State message: arrText = new arrText('','',Color.Transparent);
  pageStack: NavPathStack = new NavPathStack();
  @State value: number = 0;
  private changeOrientation(isLandscape: boolean) {
    let context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context).then((lastWindow) => {
      let orientation = isLandscape ? window.Orientation.LANDSCAPE : window.Orientation.PORTRAIT;
      lastWindow.setPreferredOrientation(orientation, (err: BusinessError) => {
      });
    }).catch((err: BusinessError) => {
      console.error(`获取窗口失败: ${JSON.stringify(err)}`);
    });
  }

  aboutToAppear(): void {
    this.changeOrientation(true)
  }

  aboutToDisappear(): void {
    this.changeOrientation(false)
  }

  build() {
    NavDestination() {
      if (this.message.effect === '文字渐变效果'){
        Row() {
          Text(this.message.content)
            .fontSize(60)
            .fontWeight(FontWeight.Bold)
            .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
        }
        .linearGradient({
          direction: GradientDirection.Right,
          colors: [[$r('app.color.gradient_start_color'), 0.0], [$r('app.color.gradient_end_color'), 1]]
        })
        .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
      }else if (this.message.effect === '歌词滚动效果') {
        Row() {
          Text(this.message.content)
            .fontSize(60)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
        }
        .linearGradient({
          direction: GradientDirection.Right,
          colors: [[this.message.color === Color.Transparent ? Color.Red : this.message.color,
            0.0], [this.message.color === Color.Transparent ? Color.Red : this.message.color,
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
      }else if (this.message.effect === '文字倒影效果') {
        Stack() {
          Text(this.message.content)
            .fontSize(60)
            .fontColor(this.message.color === Color.Transparent ? Color.Red :
              this.message.color)
            .fontWeight(FontWeight.Bold)
          Text(this.message.content)
            .fontSize(60)
            .fontColor(this.message.color === Color.Transparent ? Color.Red :
              this.message.color)
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
            [this.message.color === Color.Transparent ? Color.Red : this.message.color, 0.50],
            [$r('app.color.text_reflection_color'), 1]]
        })
        .height(148)
        .alignContent(Alignment.Top)
        .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
      }else if (this.message.effect==='跑马灯渐变效果') {
        Row() {
          Column() {
            Text(this.message.content)
              .width($r('app.string.ninety_percent'))
              .fontColor(this.message.color === Color.Transparent ? Color.Black :
                this.message.color)
              .fontSize(60)
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
            [this.message.color === Color.Transparent ? Color.Black : this.message.color, 0.8],
            [Color.Transparent, 1]]
        })
        .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pageStack = context.pathStack
      this.message = context.pathInfo.param as arrText
    })
  }
}

@Builder
export function FullScreenBuilder() {
  FullScreen()
}