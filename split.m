disp("Ban muon lam gi?")
disp("De ma hoa nhan phim 1 roi enter")
disp("De giai ma nhan phim 2 roi enter")

Selection = input('Phim: ');

if (Selection == 1)
    UserInput = input('Nhap day ky tu can ma hoa: ', 's');
    %CharUserInput = convertStringsToChars(UserInput)
    %Bien doi ma tran hang ngang thanh ma tran theo yeu cau
    
    Matrix = Str2Matr(UserInput);
    
    %Chuyen doi ma tran chu cai thanh chu so
    

    NumMatrix = sym(Char2Num(Matrix));
    
    %Nhap ma tran ma hoa
    disp("Vui long nhap ma tran ma hoa")
    KeyMatrix = (0);
    while (gcd(int8(det(KeyMatrix)), 29) ~= 1)
        if ((gcd(int8(det(KeyMatrix)), 29) ~= 1) && (size(KeyMatrix,1) ~= 1))
            disp('Ma tran khong hop le')
        end
        clear KeyMatrix
        for j = 1:3
            for i = 1:3            
                check = input(['So tai hang: ' num2str(i) ';cot: ' num2str(j) ': ']);      %Kiem tra xem input co hop le khong      
                
                while (isempty(check))
                    disp("Vui long nhap lai")
                    check = input(['So tai hang: ' num2str(i) ';cot: ' num2str(j) ': ']);           
                end
                
                KeyMatrix(i,j) = check
            end
        end
    end
    
    
    %Ma hoa thong tin
    EncryptedMatrix = KeyMatrix*NumMatrix;
    
    EncryptedMatrix = mod(EncryptedMatrix, 29);

    %Xuat ma tran ma hoa ra man hinh
    disp('Ma tran chia khoa:');
    KeyMatrix
    disp('Ma tran ma hoa');
    Matr2Str(Num2Char(EncryptedMatrix))
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (Selection == 2)
    UserInput = input('Nhap day ky tu can giai ma: ', 's'); %'s'de nhan input la 1 string
    EncryptedMatrix = sym(Char2Num(Str2Matr(UserInput)))


    disp("Vui long nhap ma tran chia khoa")
    KeyMatrix = (0);
    while (gcd(sym(det(KeyMatrix)), 29) ~= 1)
        if ((gcd(sym(det(KeyMatrix)), 29) ~= 1) && (size(KeyMatrix,1) ~= 1))
            disp('Ma tran khong hop le')
        end
        clear KeyMatrix
        for j = 1:3
            for i = 1:3            
                check = input(['So tai hang: ' num2str(i) ';cot: ' num2str(j) ': ']);      %Kiem tra xem input co hop le khong      
                
                while (isempty(check))
                    disp("Vui long nhap lai")
                    check = input(['So tai hang: ' num2str(i) ';cot: ' num2str(j) ': ']);           
                end
                
                KeyMatrix(i,j) = check
            end
        end
        KeyMatrix = sym(KeyMatrix);
    end

        %Giai ma thong tin
    % Tim ma tran phu hop theo nguyen tac Modulo Inverse of a Matrix
    %Tim gia tri CommonFactor de mod(det(Keymatrix)*CommonFactor, 29) = 1
    %Sau do nhan gia tri CommonFactor voi ma tran phu hop cua KeyMatrix
    %Roi lay phan du khi chia 29 cua ma tran cuoi cung de ra duoc ma tran Modulo Inverse

    InvKeyMatrix = sym(inv(KeyMatrix));
    InvKeyMatrix = InvKeyMatrix*det(KeyMatrix);
    %Tim thua so chung
    for i = 1:29
        if (mod(sym(det(KeyMatrix))*i, 29) == 1)
            CommonFactor = i;
            break;
        end
    end
    InvKeyMatrix = InvKeyMatrix*CommonFactor;
    InvKeyMatrix = mod(InvKeyMatrix, 29);

    %Giai ma ma tran EncryptedMatrix
    DecryptedMatrix = InvKeyMatrix*EncryptedMatrix;
    % DecryptedMatrix = int8(DecryptedMatrix);

    %Bien doi DecryptedMatrix sang dang chia lay du cua 29
    DecryptedMatrix = mod(sym(DecryptedMatrix), 29);

    %Chuyen DecryptedMatrix sang dang chu binh thuong

    CharMatrix = Num2Char(DecryptedMatrix);
    disp('Thong tin giai ma:')
    Matr2Str(CharMatrix)

end


function alp = Char2Num(input)
    alphabet = '/ abcdefghijklmnopqrstuvwxyz';
    clear alp;
    
    for j = 1:size(input,2)
        for i = 1:3
            for k = 1:length(alphabet)
                if (input(i,j) == alphabet(k))
                    alp(i,j) = k;
                    break;
                else alp(i,j) = 1;
                end 
            
            end
        
        end
    end
end

function invalp = Num2Char(input)
    alphabet = '/ abcdefghijklmnopqrstuvwxyz';
    invalp = ''; %type cya invalp phai la char thi moi chap nhan du lieu dung
    
    for j = 1:size(input,2)
        for i = 1:3
            for k = 1:length(alphabet)
                if (input(i,j) == k)
                    invalp(i,j) = alphabet(k);
                    break;
                else invalp(i,j) = '/';
                end 
            
            end
        
        end
    end
end

function Message = Matr2Str(CharMatrix)
    clear Message;
    for j = 1:size(CharMatrix,2)
        for i = 1:3
            Message( (j - 1)*3 + i ) = CharMatrix(i,j);
        
        end
    end
end

function Message = Str2Matr(CharMatrix)
    limitCheck = 0;
    Message = '';
    for j = 1:length(CharMatrix)
        if limitCheck == 1
            break
        end
        for i = 1:3
            if ((3*(j-1) + i) > length(CharMatrix))
                
                limitCheck = 1;
                break
            end
            Message(i,j) = CharMatrix(3*(j-1) + i);
            
        end
        
    
    end  
end 