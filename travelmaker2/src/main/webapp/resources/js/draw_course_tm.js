document.write('<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>');

// 버튼 클릭 횟수
var btnCount = 1;
var toggle = true;
// 시작 좌표 순서쌍 (x,y)
var x = 180;
var y = 100;

// ContextPath 가져오기
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
}

// 기본 출발노드 생성 - 처음 및 초기화 시
function drawDefaultNode(x, y) {
	var canvas = document.getElementById('canvas');
	if (canvas.getContext) {
		var ctx = canvas.getContext('2d');
		
		var radius = 15;
		
		// 원(Outer) 반지름 :15 / 둘레 : 2pi
		ctx.beginPath();
		ctx.arc(x, y, radius, 0, Math.PI * 2);
		ctx.fillStyle = "#29088A";
		ctx.fill();
		
		// 원(Inner)
		ctx.beginPath();
		ctx.arc(x, y, 10, 0, Math.PI * 2);
		
		// 기본 노드 색상
		ctx.fillStyle = "#BDBDBD";
		ctx.fill();
		
		// 텍스트 추가
		addText(x, y + 25, "출발");
		
		// toggle값에 따라 방향 반전 (drawCurve 호출시 toggle)
		if (toggle) {
			x += radius;
		} else {
			x -= radius;
		}
		
		return [x, y];
	}
}


// 클릭 시 직선1 노드1 생성 , 노드 4개 생성 되면 커브로 연결
function drawNodeAndLine() {

	if (btnCount == 16) {
		 Swal.fire({
			  title: '여행지는 15개까지\n입력할 수 있습니다.',
			  width: 600,
			  padding: '3em',
			  confirmButtonColor: '#5D9FFF',
			  background: '#fff url(' + getContextPath() + '/resources/images/alert.png)',
			  backdrop: 'rgba(40,23,100,0.1)',  
			  allowOutsideClick : true
			});
		 return;
	}

  // 노드 4개 생성한 후 커브
  if (btnCount % 4 == 0) {
      if (toggle) {
          [x, y] = drawCurve_R(x, y); // 우측 곡선 그린 후 좌표 이동
      } else {
          [x, y] = drawCurve_L(x, y); // 좌측 곡선 그린 후 좌표 이동
      }
      toggle = !toggle; // 커브할 때 마다 토글
      [x, y] = drawNode(x, y); // 노드 그린 후 좌표 이동
      btnCount++;

  } else {
      [x, y] = drawLine(x, y); // 직선 그린 후 좌표 이동
      [x, y] = drawNode(x, y); // 노드 그린 후 좌표 이동
      btnCount++;
  }

}

// 좌표(x,y)에서 lineLength 만큼 직선 연결 -> 이동한 좌표 반환
function drawLine(x, y) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        var lineLength = 180; // 선 길이
        ctx.lineWidth = 4; // 선 굵기
        ctx.strokeStyle = "#29088A";

        ctx.beginPath();
        ctx.moveTo(x, y);

        // toggle값에 따라 방향 반전 (drawCurve 호출시 toggle)
        if (toggle) {
            ctx.lineTo(x + lineLength, y);
            x += lineLength;
        } else {
            ctx.lineTo(x - lineLength, y);
            x -= lineLength;
        }

        ctx.closePath();
        ctx.stroke();
        return [x, y];

    }
}

// 좌표(x,y)에 반지름 15짜리 원 만들고 좌표 이동 -> 이동한 좌표 반환
// 여행지 텍스트 추가
function drawNode(x, y) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        var radius = 15;

        // 원(Outer) 반지름 :15 / 둘레 : 2pi
        ctx.beginPath();
        ctx.arc(x, y, radius, 0, Math.PI * 2);
        ctx.fillStyle = "#29088A";
        ctx.fill();

        // 원(Inner)
        ctx.beginPath();
        ctx.arc(x, y, 10, 0, Math.PI * 2);

        ctx.fillStyle = "#58ACFA";
        ctx.fill();
        
        // 텍스트 추가
        addText(x, y + 25, document.getElementById('name').value);

        // toggle값에 따라 방향 반전 (drawCurve 호출시 toggle)
        if (toggle) {
            x += radius;
        } else {
            x -= radius;
        }

        return [x, y];

    }
}

// 노드 4개 생성시 : 좌표(x,y)에서 좌측 커브 + 노드 생성후 좌표 반환
function drawCurve_R(x, y) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        var lineLength = 50;
        var curveRadius = 60;

        ctx.lineWidth = 4; // 선 굵기
        ctx.strokeStyle = "#29088A"; // 선 색깔

        // 직선(상)
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x + lineLength, y);
        ctx.closePath();
        ctx.stroke();
        x += lineLength;

        // 곡선 (반원)
        ctx.beginPath();
        ctx.arc(x, y + curveRadius, curveRadius, Math.PI * 3 / 2, Math.PI / 2, false);
        ctx.stroke();
        y += curveRadius * 2  // y값 이동

        // 직선(하)
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x - lineLength, y);
        ctx.closePath();
        ctx.stroke();
        x -= lineLength;

        return [x, y];
    }
}

// 노드 4개 생성시 : 좌표(x,y)에서 우측 커브(좌측과 반전) + 노드 생성후 좌표 반환
function drawCurve_L(x, y) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        var lineLength = 50;
        var curveRadius = 60;

        ctx.lineWidth = 4; // 선 굵기
        ctx.strokeStyle = "#29088A"; // 선 색깔

        // 직선(상)
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x - lineLength, y);
        ctx.closePath();
        ctx.stroke();
        x -= lineLength;

        // 곡선 (반원)
        ctx.beginPath();
        ctx.arc(x, y + curveRadius, curveRadius, Math.PI * 3 / 2, Math.PI / 2, true);
        ctx.stroke();
        y += curveRadius * 2  // y값 이동

        // 직선(하)
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x + lineLength, y);
        ctx.closePath();
        ctx.stroke();
        x += lineLength;

        return [x, y];
    }
}

// 노드에 여행지 이름 텍스트로 추가
function addText(x, y, text) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        ctx.font = '25px Sans-Serif';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'hanging';
        ctx.fillStyle = "#4C4C4C";

        ctx.fillText(text, x, y, 150);
    }
}

// 처음상태로 초기화
function clearNode() {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // 전역변수 초기화
        btnCount = 1;
        toggle = true;
        x = 180;
        y = 100;

        // 출발 노드 생성
        [x, y] = drawDefaultNode(x, y);
    }
}

// canvas 파일 이미지 변환 후 서버 업로드
function uploadCanvasData() {
	var frm = document.frm;
	var title = frm.title.value;
	var s_date = frm.s_date.value;
	var e_date = frm.e_date.value;
	var content = frm.content.value;
	
	if (!title) {
		// alert("제목을 입력하세요");
		 Swal.fire({
			  title: '제목을 입력하세요.',
			  width: 600,
			  padding: '3em',
			  confirmButtonColor: '#5D9FFF',
			  background: '#fff url(' + getContextPath() + '/resources/images/alert.png)',
			  backdrop: 'rgba(40,23,100,0.1)',  
			  allowOutsideClick : true
			});
		return false;
	} else if (!s_date) {
		 Swal.fire({
			  title: '출발일을 입력하세요.',
			  width: 600,
			  padding: '3em',
			  confirmButtonColor: '#5D9FFF',
			  background: '#fff url(' + getContextPath() + '/resources/images/alert.png)',
			  backdrop: 'rgba(40,23,100,0.1)',  
			  allowOutsideClick : true
			});
		return false;
	} else if (!e_date) {
		 Swal.fire({
			  title: '도착일을 입력하세요.',
			  width: 600,
			  padding: '3em',
			  confirmButtonColor: '#5D9FFF',
			  background: '#fff url(' + getContextPath() + '/resources/images/alert.png)',
			  backdrop: 'rgba(40,23,100,0.1)',  
			  allowOutsideClick : true
			});
		return false;
	} else if (!content) {
		 Swal.fire({
			  title: '내용을 입력하세요.',
			  width: 600,
			  padding: '3em',
			  confirmButtonColor: '#5D9FFF',
			  background: '#fff url(' + getContextPath() + '/resources/images/alert.png)',
			  backdrop: 'rgba(40,23,100,0.1)',  
			  allowOutsideClick : true
			});
		return false;
	}	
	
	// 도착일이 출발일보다 늦으면 저장 안되도록
	var startDate = new Date(s_date);
	var endDate = new Date(e_date);
	if (startDate > endDate) {
		 Swal.fire({
			  title: '도착일이 출발일보다\n빠릅니다.',
			  width: 600,
			  padding: '3em',
			  confirmButtonColor: '#5D9FFF',
			  background: '#fff url(' + getContextPath() + '/resources/images/alert.png)',
			  backdrop: 'rgba(40,23,100,0.1)',  
			  allowOutsideClick : true
			});
		return false;
	}

    // 폼 데이터 생성
    var form = $('#frm')[0];
	var formData = new FormData(form);

    var canvas = document.getElementById("canvas");
    var imageBase64 = canvas.toDataURL('image/png');

    // base64 to blob
    var decodedImg = atob(imageBase64.split(',')[1]);  // base64 데이터 디코딩
    var array = [];
    for (var i = 0; i < decodedImg.length; i++) {
    	array.push(decodedImg.charCodeAt(i));
    }
    
    var file = new Blob([new Uint8Array(array)], {type: 'image/png'}); // Blob 생성
																		
    var today = new Date();
    var fileName = 'courseImg_'+ today.toLocaleDateString() + '_' + today.getMilliseconds() + '.png';
    formData.append("file", file, fileName);

    $.ajax({
        type: 'POST',
        url: 'bdInsert.do',
        data: formData,
        processData: false,	// data 파라미터 강제 string 변환 방지
        contentType: false,	// application/x-www-form-urlencoded; 방지
        enctype: 'multipart/form-data',
        cache: false,
        success: function (data) {
            Swal.fire({
  			  title: '게시글이 등록 되었습니다.',
  			  width: 600,
  			  padding: '3em',
  			  confirmButtonColor: '#5D9FFF',
  			  background: '#fff url(' + getContextPath() + '/resources/images/alert.png)',
  			  backdrop: 'rgba(40,23,100,0.1)',  
  			  allowOutsideClick : true
  			}).then(function() {
  				if (data == 'master') {
  					location.replace('../admin/adminMain.do');
  				} else {
  					location.replace('bdList.do');
  				}
  			});
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}