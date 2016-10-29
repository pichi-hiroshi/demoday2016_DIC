class ContactsController < ApplicationController
    
    def index
      @contacts = Contact.all
    end
    
    def new
      if params[:back]
        @contact = Contact.new(contacts_params)
      else
        @contact = Contact.new
      end
    end
    
    def create
#      Contact.create(contacts_params)
#      redirect_to root_path, notice: 'お問い合わせ完了しました'
#      redirect_to new_contact_path

       @contact = Contact.new(contacts_params)
       if @contact.save
         redirect_to root_path, notice: 'お問い合わせありがとうございました。'
         NoticeMailer.sendmail_contact(@contact).deliver
         if @contact.reply == true
           NoticeMailer.sendmail_reply(@contact).deliver
         end
       else
         render action: 'new'
       end

    end
    
    def edit
      @contact = Contact.find(params[:id])
    end
    
    def update
      @contact = Contact.find(params[:id])
      @contact.update(contacts_params)
    end
    
    def confirm
      @contact = Contact.new(contacts_params)
    end
    
    private
        def contacts_params
          params.require(:contact).permit(:contents,:mail,:reply,:privacy)
        end
end
