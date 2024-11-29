import shutil


def move_diagram(filename: str):
    shutil.move(f"{filename}.png", f"../imgs/{filename}.png")
