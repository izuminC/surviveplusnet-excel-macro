VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Data_TextNumberIncrement"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'------------------------------------------------------------------------
'   Data_TextNumberIncrement �N���X
'------------------------------------------------------------------------
'   �ړI�F      �e�L�X�g���̐��l�̃C���N�������g���i��N���X�ł��B
'   ���߁F      Data.�����̐��l���C���N�������g �p�̃N���X�ł��B
'   �g�p���@�F
'   �ύX�����F  SHIN-ICHI 2009/3/23 - �I���W�i���i�v���V�[�W�����̕ϐ��⃍�W�b�N���番���j
'   Copyright(C) 2009 SHIN-ICHI all rights reservd.
'------------------------------------------------------------------------

'
' �p�^�[�����o�Ɏg�p���鐳�K�\���I�u�W�F�N�g�ł��B
' �C���X�^���X���ɃL���b�V�����āA�č쐬�ɂ��p�t�H�[�}���X�̒ቺ��h���܂��B
'
Dim regNotNumber As Object
Dim regEndNumber As Object
Dim matches As Object
   
'------------------------------------------------------------------------
'   �ړI�F      �C���X�^���X�����������܂��B
'   ���߁F
'   �ύX�����F  SHIN-ICHI 2009/3/23 - �I���W�i��
'------------------------------------------------------------------------
Private Sub Class_Initialize()
    
    Set regNotNumber = CreateObject("VBScript.RegExp")
    regNotNumber.Pattern = "[^0-9]"
    
    Set regEndNumber = CreateObject("VBScript.RegExp")
    regEndNumber.Pattern = "^(.*)([^0-9])([0-9]+)([^0-9]?)(.*?)$"
    
End Sub

'------------------------------------------------------------------------
'   �ړI�F      �C���X�^���X�̔j�����s���܂��B
'   ���߁F
'   �ύX�����F  SHIN-ICHI 2009/3/23 - �I���W�i��
'------------------------------------------------------------------------
Private Sub Class_Terminate()
    On Error Resume Next
    Set matches = Nothing
    Set regNotNumber = Nothing
    Set regEndNumber = Nothing
End Sub

'------------------------------------------------------------------------
'   �ړI�F      �w�肳�ꂽ�e�L�X�g�̖����̐��l���C���N�������g���ĕԂ��܂��B
'   ���́F      ���� text - ���l���C���N�������g����e�L�X�g���w�肵�܂��B
'   �߂�l�F    �����̐��l���C���N�������g���ꂽ�e�L�X�g��Ԃ��܂��B�C���N�������g�o���Ȃ��Ƃ��͂��̂܂ܕԂ��܂��B
'   ���߁F
'   �g�p���@�FnewText = textNumberIncrement.Increment( targetText )
'   �ύX�����F  SHIN-ICHI 2009/3/23 - �I���W�i��
'------------------------------------------------------------------------
Public Function Increment(ByVal targetText As String) As String

    If targetText = "" Then Exit Function
    
    If regNotNumber.Test(targetText) Then
        Set matches = regEndNumber.Execute(targetText)
        
        If matches.Count > 0 Then
            With matches(0)
                Dim oldNumber As String: oldNumber = .SubMatches(2)
                Dim newNumber As String: newNumber = CInt(oldNumber) + 1
                If Len(newNumber) < Len(oldNumber) Then
                    newNumber = String(Len(oldNumber) - Len(newNumber), "0") & newNumber
                End If
                
                'Return
                Increment = .SubMatches(0) & .SubMatches(1) & newNumber & .SubMatches(3) & .SubMatches(4)
            End With
        Else
            'Return
            Increment = targetText
        End If
    
    Else
        'Return
        Increment = CInt(targetText) + 1
    End If
End Function
