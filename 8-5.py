from tkinter import *
root =Tk()
root.geometry("300x100")

label1=Label(root, text="마리오카트 패배자")
label2=Label(root,text="이은지",font=('궁서체',30),bg='blue',fg='yellow')

label1.pack()
label2.pack()

root.mainloop()
