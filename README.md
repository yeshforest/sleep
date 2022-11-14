# sleep 수면시간 관리 앱
수면시간은 4시간30분, 6시간, 7시간 30분, 9시간 단위로 하는 것이 좋다. 
<br>
잘 시간을 입력하면, 일어나야 할 시간을 대신 계산해준다. 실제 수면시간을 저장해서 한 눈에 관리 할 수 있다.
<br>
### 시연영상
https://youtu.be/6HpN0OdOaaw
<br>
## 구현내용
‘밤 용 화면’에서는 사용자는 datepicker를 이용하여 잠들시간,기상시간을 선택하면 앱이 그에맞게 시간을 계산해준다.
<br>
<br>
![image](https://user-images.githubusercontent.com/88522164/201654268-f287d8ab-d280-449d-9a15-1d71b97ff0ca.png)
<br>
<br>
![image](https://user-images.githubusercontent.com/88522164/201654368-fc255da5-a1c8-4fbb-b4cf-ae9853470d5a.png)

‘아침용 화면’에서 사용자는 정확한 수면시간을 datepicker를 이용하여 입력하고 저장할 수 있다. 
<br>
통계 보러가기 라는 UIButton을 누르면 통계 확인용 화면으로 이동 할 수 있다. 
<br>
<br>
![image](https://user-images.githubusercontent.com/88522164/201654578-09dc1ebc-0108-405f-999c-72237131b75a.png)
![image](https://user-images.githubusercontent.com/88522164/201654593-755e3b4d-9bb3-4777-970f-7cea92e1c284.png)
![image](https://user-images.githubusercontent.com/88522164/201654607-c5763b52-482d-4c06-8300-28416a87e80e.png)

‘통계 확인용 화면’에서는 저장된 데이타들(날짜, 수면시간)을 tableView를 이용하여 보여준다. 
<br>
‘통계 보러 이동’ 버튼을 누르면 수면시간을 대략적으로 계산하여 차트로 표현해준다.
