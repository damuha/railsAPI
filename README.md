# README

# 事前準備
```
  1：ユーザー登録
  curl -X POST http://localhost:3000/users -d 'users[user_name]=dayoung.ham'

  2：チケット登録
  curl -X POST http://localhost:3000/tickets -d 'tickets[user_id]=1&tickets[ticket_name]=radwimps&tickets[give_flg]=0'

  3：ユーザーが持っているチケット情報取得
  http://localhost:3000/users/{user_id}

  4：チケット譲渡
  curl -X PUT http://localhost:3000/tickets/{ticket_id} -d 'tickets[give_flg]=1&tickets[give_user_id]={譲渡するユーザーID}'

  5：譲渡できたか確認
  http://localhost:3000/users/{ticket_id}
```

# API仕様
  [あるユーザーが所有するチケットの情報を取得できるAPI]
    リクエスト
      http://localhost:3000/users/{user_id}
      ※DBに登録されているユーザーID

```
    ※データはテストデータ
    レスポンス
      ユーザーID："user_id": 2,
      ユーザー名："user_name": "testuser1",
      チケットID："ticket_id": 8,
      チケット名："ticket_name": "radwimps",
      譲渡相手："give_user_id": null,
      譲渡ステータス："give_flg": 3,
      譲渡元のチケットID："original_ticket_id": 7
```

  [譲渡機能を実現するために必要なAPI]
    リクエスト
    curl -X PUT http://localhost:3000/tickets/{譲渡するチケットID} -d 'tickets[give_flg]=1&tickets[give_user_id]={譲渡相手}'
      ※give_flgで譲渡したいか判断 #0:譲渡なし　1:譲渡予定　2：譲渡済　3:譲渡されたチケット

    ```
      PUT
        ・既存のチケットの[tickets.give_flg]を[2](譲渡済)に更新
        ・譲渡したチケットレコードを新たに以下で作成する。←後から譲渡したひとされた人を追うため
        　チケット名：ticket_name: 既存レコードからコピー
        　ユーザーID：user_id: 譲渡するユーザーID
        　譲渡ステータス：give_flg:3
          元のチケット番号：original_ticket_id: 既存のチケットID
    ```

    ```
    レスポンス
      ・譲渡したチケット情報
        チケットID："id": 7,
        チケット名："ticket_name": "radwimps",
        ユーザーID："user_id": 1,
        譲渡ステータス："give_flg": 2,
        譲渡相手："give_user_id": 2,
        譲渡元のチケットID："original_ticket_id": null

      ・譲渡後のチケット情報
            チケットID："id": 25,
            チケット名："ticket_name": "radwimps",
            ユーザーID："user_id": 2,
            譲渡ステータス："give_flg": 3,
            譲渡相手："give_user_id": null,　※譲渡されたチケットのため譲渡相手の情報はNULL
            譲渡元のチケットID："original_ticket_id": 7
    ```

# 実装について
  ・ユーザーが譲渡する際は譲渡フラグ[1]をたてて、譲渡したいことがわかるようにした
  　メリット：譲渡したいかどうか判断できる　
  　デメリット：ユーザーが譲渡ボタンを押したら譲渡フラグを1にして引き渡される必要があるため、その機能に依存してしまう

  ・譲渡したチケットはもう一つレコードを作成して管理するようにした
  　→あくまで譲渡したら、譲渡したユーザーが所有するチケットとするため。
  　メリット：譲渡されたユーザーのチケットとして新たにチケットが作成されるため、チケット管理がしやすい
  　デメリット：裏側でチケットの確認をする際、同じ情報のチケットデータがあるように見えるので、混乱しやすい
  ・譲渡したチケットには以下がわかるようににした
    １、譲渡前のチケットID
    ２、譲渡してくれたユーザーID
    メリット：譲渡前にチケットIDもデータとして登録するため、誰からどのチケットを譲渡されたか追跡しやすい
    デメリット：とくになし
  ・譲渡したチケットは譲渡済のチケットとわかるように譲渡フラグ[2]、譲渡されたチケットは[3]をたててわかるようにした
  　メリット：譲渡したチケットなのか、フラグで確認できるため、譲渡状況が一眼でわかる。
  　デメリット：とくになし
  ・譲渡した後は確認のため、譲渡したチケットと譲渡後のチケットを表示させるようにした。

# テスト実施に使用した時間
  設計：5h
  コーディング：15h　※rubyについて調べた時間も含む
  テスト12h　※rspecについて調べた時間も含む
