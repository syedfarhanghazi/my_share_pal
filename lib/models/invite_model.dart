class InviteModel{

  String _firstName, _lastName, _mobile, _img, _decision, _invitedBy, _ministryCode;
  int _answers;




  String get firstName => _firstName;

  get lastName => _lastName;

  int get answers => _answers;

  get decision => _decision;

  get img => _img;

  get mobile => _mobile;

  InviteModel(this._firstName, this._lastName, this._mobile, this._img,
      this._decision, this._invitedBy, this._ministryCode, this._answers);

  get ministryCode => _ministryCode;

  get invitedBy => _invitedBy;


}