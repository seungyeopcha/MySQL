import pymysql

# 변수 선언
con,cur =None,None
data1,data2,data3,data4="","","",""
row=None

#main
conn=pymysql.connect(host='127.0.0.1',user='root',password='0000',db='soloDB',charset='utf8')
cur=conn.cursor()

cur.execute("select * from userTable")

print("사용자아이디    사용자이름     이메일            출생연도" )
print("-----------------------------------------------------------------")

while(True):
    row=cur.fetchone()
    if row==None:
        break
    data1=row[0]
    data2=row[1]
    data3=row[2]
    data4=row[3]
    print("%5s   %15s   %20s   %d" % (data1,data2,data3,data4))

conn.close()
