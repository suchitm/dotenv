# dotenv
# Setup of custom environment
git clone https://github.com/suchitm/dotenv.git
#
mv .vimrc .vimrc_orig
mv .tmux.conf .tmux.conf_orig
#
ln -s dotenv/dotvim/vimrc .vimrc
ln -s dotevn/tmux/tmux.conf .tmux.conf
#
cd dotenv
git submodule update --init recursive
