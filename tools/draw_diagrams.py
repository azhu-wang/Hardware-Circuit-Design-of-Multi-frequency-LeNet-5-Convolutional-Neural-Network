"""Generate repository diagrams using Pillow; no external assets are required."""

from pathlib import Path
from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "docs" / "images"
OUT.mkdir(parents=True, exist_ok=True)

BG = "#07111f"
PANEL = "#0f2238"
BLUE = "#40a9ff"
CYAN = "#42e8d3"
GOLD = "#ffc857"
GREEN = "#68d391"
WHITE = "#f4f8ff"
MUTED = "#9eb4ca"
RED = "#ff7b72"


def font(size: int, bold: bool = False):
    name = "seguisb.ttf" if bold else "segoeui.ttf"
    return ImageFont.truetype(str(Path("C:/Windows/Fonts") / name), size)


def canvas(title: str, subtitle: str):
    image = Image.new("RGB", (1600, 900), BG)
    draw = ImageDraw.Draw(image)
    draw.text((70, 48), title, font=font(50, True), fill=WHITE)
    draw.text((72, 112), subtitle, font=font(24), fill=MUTED)
    return image, draw


def box(draw, xy, title, lines, color=BLUE):
    draw.rounded_rectangle(xy, radius=22, fill=PANEL, outline=color, width=4)
    x1, y1, x2, _ = xy
    draw.text(((x1+x2)//2, y1+30), title, font=font(27, True), fill=WHITE, anchor="ma")
    for idx, line in enumerate(lines):
        draw.text(((x1+x2)//2, y1+82+idx*35), line, font=font(21), fill=MUTED, anchor="ma")


def arrow(draw, start, end, color=CYAN, label=None):
    draw.line([start, end], fill=color, width=7)
    ex, ey = end
    sx, sy = start
    if abs(ex-sx) >= abs(ey-sy):
        tip = [(ex, ey), (ex-18, ey-12), (ex-18, ey+12)]
    else:
        tip = [(ex, ey), (ex-12, ey-18), (ex+12, ey-18)]
    draw.polygon(tip, fill=color)
    if label:
        draw.text(((sx+ex)//2, (sy+ey)//2-16), label, font=font(19, True), fill=color, anchor="ms")


def architecture():
    image, draw = canvas(
        "Multi-rate LeNet-5 FPGA Pipeline",
        "One global clock, staged clock-enable pulses, and fixed-point INT8 data",
    )
    xs = [65, 370, 675, 980, 1285]
    widths = [245, 245, 245, 245, 245]
    titles = ["Input", "Stage 1", "Stage 2", "Stage 3", "Classifier"]
    details = [
        ["30 x 30 x 1", "signed Q0.7", "image ROM"],
        ["3 x 3 Conv", "6 channels", "DSP48 pipeline", "ReLU + Pool"],
        ["3 x 3 Conv", "12 channels", "ReLU + Pool"],
        ["1 x 1 Conv", "2 channels", "6 x 6 output"],
        ["72 x 10 FC", "INT32 logits", "argmax"],
    ]
    colors = [BLUE, CYAN, GOLD, GREEN, BLUE]
    for x, w, title, lines, color in zip(xs, widths, titles, details, colors):
        box(draw, (x, 255, x+w, 515), title, lines, color)
    for left, right in zip(xs[:-1], xs[1:]):
        arrow(draw, (left+245, 385), (right-18, 385))

    draw.rounded_rectangle((140, 640, 1460, 795), radius=28, fill="#0b1b2c", outline="#29445e", width=3)
    draw.text((800, 673), "sys_clk", font=font(29, True), fill=WHITE, anchor="ma")
    draw.line((250, 735, 1350, 735), fill=BLUE, width=5)
    for x, label, color in [(492, "CE every cycle", CYAN), (797, "CE every 2 cycles", GOLD), (1102, "CE every 4 cycles", GREEN)]:
        draw.ellipse((x-10, 725, x+10, 745), fill=color)
        draw.text((x, 765), label, font=font(19, True), fill=color, anchor="ma")
    image.save(OUT / "architecture.png")


def quantization():
    image, draw = canvas(
        "Bit-exact Quantization Flow",
        "Power-of-two scales keep RTL requantization to arithmetic shifts",
    )
    stages = [
        ("Input", ["scale = 128", "INT8 / Q0.7"], BLUE),
        ("Conv1", ["weight scale = 128", "activation scale = 8", "RTL shift = 11"], CYAN),
        ("Conv3", ["weight scale = 128", "activation scale = 2", "RTL shift = 9"], GOLD),
        ("Conv5", ["weight scale = 128", "activation scale = 2", "RTL shift = 7"], GREEN),
        ("FC", ["72 inputs", "INT32 logits", "no requant needed"], BLUE),
    ]
    x_positions = [65, 370, 675, 980, 1285]
    for x, (title, lines, color) in zip(x_positions, stages):
        box(draw, (x, 235, x+245, 520), title, lines, color)
    for left, right in zip(x_positions[:-1], x_positions[1:]):
        arrow(draw, (left+245, 377), (right-18, 377))
    draw.rounded_rectangle((220, 635, 1380, 795), radius=25, fill="#0b1b2c", outline=CYAN, width=3)
    draw.text((800, 672), "RTL rule", font=font(26, True), fill=CYAN, anchor="ma")
    draw.text((800, 724), "accumulate in a wide signed register  ->  arithmetic shift  ->  ReLU  ->  saturate to INT8",
              font=font(23), fill=WHITE, anchor="ma")
    draw.text((800, 764), "Weights and images are exported as legal COE files; all zero-points are zero.",
              font=font(20), fill=MUTED, anchor="ma")
    image.save(OUT / "quantization-flow.png")


def power():
    image, draw = canvas(
        "FPGA Power Reduction Options",
        "Apply the low-risk methods first; voltage changes depend on the device and board regulator",
    )
    rows = [
        ("1", "Clock enable", "Stops register and datapath switching", "Implemented", GREEN),
        ("2", "BRAM / DSP inference", "Uses hard memory and multiplier blocks", "Implemented: 220 DSPs", CYAN),
        ("3", "Clock gating buffer", "Reduces clock-tree activity", "Use BUFGCE after validation", GOLD),
        ("4", "Frequency scaling", "Reduces dynamic power roughly with f", "MMCM / PLL + handshake", BLUE),
        ("5", "Voltage scaling", "Dynamic power benefits roughly with V squared", "Board- and speed-grade-specific", RED),
    ]
    y = 205
    for number, title, effect, status, color in rows:
        draw.rounded_rectangle((120, y, 1480, y+105), radius=22, fill=PANEL, outline="#29445e", width=2)
        draw.ellipse((150, y+22, 211, y+83), fill=color)
        draw.text((180, y+51), number, font=font(26, True), fill=BG, anchor="mm")
        draw.text((250, y+25), title, font=font(26, True), fill=WHITE)
        draw.text((560, y+29), effect, font=font(21), fill=MUTED)
        draw.rounded_rectangle((1120, y+25, 1435, y+80), radius=18, fill="#081725", outline=color, width=2)
        draw.text((1277, y+52), status, font=font(19, True), fill=color, anchor="mm")
        y += 125
    image.save(OUT / "power-options.png")


if __name__ == "__main__":
    architecture()
    quantization()
    power()
    print(OUT)
